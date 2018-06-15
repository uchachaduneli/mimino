<%--
  Created by IntelliJ IDEA.
  User: ME
  Date: 10/23/2017
  Time: 3:38 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="header.jsp" %>
<script>

  $(document).ready(function () {

    $('input[name="datetime"]').datetimepicker({
      weekStart: 1,
      todayBtn: 1,
      autoclose: 1,
      todayHighlight: 1,
      startView: 2,
      forceParse: 0,
      showMeridian: 1,
      use24hours: 1
    }).on('changeDate', function (ev) {
    });

    $('.srch').keypress(function (e) {
      var key = e.which;
      if (key == 13) {
        $('#srchBtnId').click();
        return false;
      }
    });

  });

  app.controller("angController", ['$scope', '$http', '$filter', '$window', 'Upload', '$timeout', function ($scope, $http, $filter, $window, Upload, $timeout) {
    $scope.start = 0;
    $scope.page = 1;
    $scope.limit = "10";
    $scope.srchCase = {};

    $scope.loadMainData = function () {
      $('#loadingModal').modal('show');

      function getMainData(res) {
        $scope.list = res.data;
        $('#loadingModal').modal('hide');
      }

      if ($scope.srchCase != undefined) {
        if ($scope.srchCase.nextActivity != undefined && $scope.srchCase.nextActivity.includes('/')) {
          $scope.srchCase.nextActivity = $scope.srchCase.nextActivity.split(/\//).reverse().join('-')
        }
        if ($scope.srchCase.nextActivityTo != undefined && $scope.srchCase.nextActivityTo.includes('/')) {
          $scope.srchCase.nextActivityTo = $scope.srchCase.nextActivityTo.split(/\//).reverse().join('-')
        }
      }
      ajaxCall($http, "emails/get-emails?start=" + $scope.start + "&limit=" + $scope.limit, angular.toJson($scope.srchCase), getMainData);
    }

    $scope.loadMainData();

    function getUsers(res) {
      $scope.users = res.data;
    }

    ajaxCall($http, "users/get-users", null, getUsers);

    function getFolders(res) {
      $scope.folders = res.data;
    }

    ajaxCall($http, "emails/get-email-folders", null, getFolders);

    $scope.showDetails = function (id) {
      if (id != undefined) {
        var selected = $filter('filter')($scope.list, {id: id}, true);
        $scope.slcted = selected[0];
      }
    };

    $scope.handleDoubleClick = function (id) {
      $scope.showDetails(id);
      $('#detailModal').modal('show');
    };

    $scope.rowNumbersChange = function () {
      $scope.start = 0;
      $scope.loadMainData();
    }

    $scope.handlePage = function (h) {
      if (parseInt(h) >= 0) {
        $scope.page += 1;
        $scope.start = $scope.start + $scope.limit;
      } else {
        $scope.page -= 1;
        $scope.start = ($scope.start - $scope.limit) < 0 ? 0 : ($scope.start - $scope.limit);
      }
      $scope.loadMainData();
    }

    $scope.openMailHtmlContent = function (content) {
      var newWindow = $window.open();
      newWindow.document.writeln(content);
      newWindow.document.close();
    }

    $scope.showMailHtmlContent = function (content) {

      var iframe = document.getElementById('foo'),
          iframedoc = iframe.contentDocument || iframe.contentWindow.document;

      iframedoc.body.innerHTML = content;
    };

    $scope.uploadFiles = function (files) {
      $scope.files = files;
      angular.forEach(files, function (file) {
        if (file && !file.$error) {
          file.upload = Upload.upload({
            url: 'https://angular-file-upload-cors-srv.appspot.com/upload',
            file: file
          });

          file.upload.then(function (response) {
            $timeout(function () {
              file.result = response.data;
            });
          }, function (response) {
            if (response.status > 0)
              $scope.errorMsg = response.status + ': ' + response.data;
          });

          file.upload.progress(function (evt) {
            file.progress = Math.min(100, parseInt(100.0 *
                evt.loaded / evt.total));
          });
        }
      });
    }
  }]);

</script>
<style>
  .thumb {
    width: 24px;
    height: 24px;
    float: none;
    position: relative;
    top: 7px;
  }

  form .progress {
    line-height: 15px;
  }

  .progress {
    display: inline-block;
    width: 100px;
    border: 3px groove #CCC;
  }

  .progress div {
    font-size: smaller;
    background: orange;
    width: 0;
  }
</style>

<button type="file" ngf-select="uploadFiles($files)" multiple
        accept="image/*" ngf-max-height="1000" ngf-max-size="1MB">
  Select Files
</button>
<br>
Files:
<ul>
  <li ng-repeat="f in files">{{f.name}} {{f.$error}} {{f.$errorParam}}
    <span class="progress" ng-show="f.progress >= 0">
        <div style="width:{{f.progress}}%"
             ng-bind="f.progress + '%'"></div>
      </span>
  </li>
</ul>
{{errorMsg}}

<br><br><br><br>

<div class="modal fade bs-example-modal-lg not-printable" id="editModal" role="dialog" aria-labelledby="editModalLabel"
     aria-hidden="true">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="editModalLabel">Enter Information</h4>
      </div>
      <div class="modal-body">
        <div class="row">
          <form class="form-horizontal" name="ediFormName">
            <div class="form-group col-sm-10 ">
              <label class="control-label col-sm-3">To, Cc</label>
              <div class="col-sm-9">
                <input type="text" ng-model="request.to" class="form-control input-sm">
              </div>
            </div>
            <div class="form-group col-sm-10 ">
              <label class="control-label col-sm-3">Message</label>
              <div class="col-sm-9">
                <input type="text" ng-model="request.content" name="info" required
                       class="form-control input-sm">
              </div>
            </div>
            <div class="form-group col-sm-10">
              <ul>
                <li ng-repeat="item in request.attachments">
                  <a href="misc/get-file?name=attachments/{{item.split('.')[0].trim()}}" target="_blank">{{item}}</a>
                </li>
              </ul>
            </div>
            <div class="form-group col-sm-10"></div>
            <div class="form-group col-sm-12 text-center">
              <a class="btn btn-app" ng-click="save()">
                <i class="fa fa-save"></i> Save
              </a>
            </div>

          </form>
        </div>
      </div>
    </div>
  </div>
</div>

<div class="modal fade bs-example-modal-lg" id="detailModal" tabindex="-1" role="dialog"
     aria-labelledby="editModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="detailModalLabel">Details</h4>
      </div>
      <div class="modal-body">
        <div class="row" id="printable">
          <table class="table table-striped">
            <tr>
              <th class="col-md-4 text-right">ID</th>
              <td>{{slcted.id}}</td>
            </tr>
            <tr>
              <th class="text-right">User</th>
              <td>{{slcted.user.userDesc}}</td>
            </tr>
            <tr>
              <th class="text-right">From</th>
              <td>{{slcted.from}}</td>
            </tr>
            <tr>
              <th class="text-right">To</th>
              <td>{{slcted.to}}</td>
            </tr>
            <tr>
              <th class="text-right">Subject</th>
              <td>{{slcted.subject}}</td>
            </tr>
            <tr>
              <th class="text-right">SendDate</th>
              <td>{{slcted.sendDate}}</td>
            </tr>
            <tr>
              <th class="text-right">ReceiveDate</th>
              <td>{{slcted.receiveDate}}</td>
            </tr>
            <tr>
              <th class="text-right">Attachments</th>
              <td>{{slcted.attachments}}
                <ul>
                  <li ng-repeat="item in slcted.attachments.split(' ')"><a
                          href="misc/get-file?name=attachments/{{item.split('.')[0].trim()}}"
                          target="_blank">{{item}}</a>
                  </li>
                </ul>
              </td>
            </tr>
            <tr>
              <th class="text-right">CreateDate</th>
              <td>{{slcted.insertDate}}</td>
            </tr>
          </table>
          <div class="text-center" style="font-weight: bold;">Content &nbsp;&nbsp; &nbsp;
            <i class="glyphicon glyphicon-new-window zoom fa-pulse pulse" style="font-size: 14px; "
               ng-click="openMailHtmlContent(slcted.content)"
               title="Opent Email Content Properly In New Window"></i>
          </div>
          <br>
          <iframe class="col-md-11" id="foo" ng-switch="showMailHtmlContent(slcted.content)"
                  frameborder="0" style="margin-left: 4.5%; height: 400px !important;"></iframe>
          <div class="form-group"><br/></div>
        </div>
      </div>
    </div>
    <div class="modal-footer">
    </div>
  </div>
</div>

<div class="row not-printable">
  <div class="col-xs-12">
    <div class="box">
      <div class="box-header">
        <div class="col-md-2">
          <button type="button" class="btn btn-block btn-primary btn-md" ng-click="init()"
                  data-toggle="modal" data-target="#editModal">
            <i class="fa fa-envelope" aria-hidden="true"></i> &nbsp;
            Add
          </button>
        </div>
        <div class="col-md-2 col-xs-offset-8">
          <select ng-change="rowNumbersChange()" class="pull-right form-control" ng-model="limit"
                  id="rowCountSelectId">
            <option value="10" selected>Show 10</option>
            <option value="15">15</option>
            <option value="30">30</option>
            <option value="50">50</option>
            <option value="100">100</option>
          </select>
        </div>
        <div class="row">
          <hr class="col-md-12"/>
        </div>
        <div class="col-md-12">
          <div id="filter-panel" class="filter-panel">
            <div class="panel panel-default">
              <div class="panel-body">

                <div class="form-group col-md-2">
                  <input type="text" class="form-control srch" ng-model="srchCase.id"
                         placeholder="ID">
                </div>
                <div class="form-group col-md-2">
                  <input type="text" class="form-control srch" ng-model="srchCase.from"
                         placeholder="From">
                </div>
                <div class="form-group col-md-2">
                  <input type="text" class="form-control srch" ng-model="srchCase.to"
                         placeholder="To">
                </div>
                <div class="form-group col-md-3">
                  <input type="text" class="form-control srch"
                         ng-model="srchCase.subject" placeholder="Subject">
                </div>
                <div class="form-group col-md-3">
                  <input type="text" class="form-control srch"
                         ng-model="srchCase.content" placeholder="Content">
                </div>
                <div class="form-group col-md-2">
                  <select class="form-control" ng-model="srchCase.folderId"
                          ng-change="loadMainData()">
                    <option value="" selected="selected">Type</option>
                    <option ng-repeat="v in folders" ng-selected="v.id === srchCase.folderId"
                            value="{{v.id}}">{{v.name}}
                    </option>
                  </select>
                </div>
                <div class="form-group col-md-2">
                  <select class="form-control" ng-model="srchCase.userId"
                          ng-change="loadMainData()">
                    <option value="" selected="selected">User</option>
                    <option ng-repeat="v in users" ng-selected="v.userId === srchCase.userId"
                            value="{{v.userId}}">{{v.userName}}
                    </option>
                  </select>
                </div>
                <div class="form-group col-md-3">
                  <div class="input-group">
                    <div class="input-append">
                      <input type="text" name="datetime" class="form-control srch"
                             placeholder="From"
                             ng-model="srchCase.sendDate">
                    </div>
                    <span class="input-group-addon">Send Date</span>
                    <div class="input-append">
                      <input type="text" name="datetime" class="form-control srch"
                             placeholder="To" ng-model="srchCase.sendDateTo">
                    </div>
                  </div>
                </div>
                <div class="form-group col-md-3">
                  <div class="input-group">
                    <div class="input-append">
                      <input type="text" name="datetime" class="form-control srch"
                             placeholder="From"
                             ng-model="srchCase.receiveDate">
                    </div>
                    <span class="input-group-addon">Receive Date</span>
                    <div class="input-append">
                      <input type="text" name="datetime" class="form-control srch"
                             placeholder="To" ng-model="srchCase.receiveDateTo">
                    </div>
                  </div>
                </div>
                <div class="form-group col-md-2">
                  <button class="btn btn-default col-md-11" ng-click="loadMainData()" id="srchBtnId">
                    <span class="fa fa-search"></span> &nbsp; &nbsp;Search &nbsp; &nbsp;
                  </button>
                </div>
              </div>
            </div>
          </div>
        </div>
        <!-- /.box-header -->
        <div class="box-body">
          <table class="table table-bordered table-hover">
            <thead>
            <tr>
              <th>ID</th>
              <th>From</th>
              <th>To</th>
              <th>Subject</th>
              <th>Attachments</th>
              <th>Crt. Date</th>
              <th class="col-md-2 text-center">Action</th>
            </tr>
            </thead>
            <tbody title="Double Click For Detailed Information">
            <tr ng-repeat="r in list" ng-dblclick="handleDoubleClick(r.id)">

              <td>{{r.id}}</td>
              <td>{{r.from}}</td>
              <td>{{r.to}}</td>
              <td>{{r.subject}}</td>
              <td>{{r.attachments.length > 0 ? 'YES('+r.attachments.split(' ').length+')':'NO'}}</td>
              <td>{{r.insertDate}}</td>
              <td class="text-center">
                <a ng-click="showDetails(r.id)" data-toggle="modal" title="Details"
                   data-target="#detailModal" class="btn btn-xs">
                  <i class="fa fa-sticky-note-o"></i>&nbsp; Details
                </a>&nbsp;&nbsp;
              </td>
            </tr>
            </tbody>
          </table>
          <div class="panel-footer">
            <div class="row">
              <div class="col col-md-12">
                <ul class="pagination pull-right">

                  <li>
                    <a ng-click="handlePage(-1)" style="cursor: pointer;"> «</a>
                  </li>
                  <li>
                    <a ng-click="handlePage(1)" style="cursor: pointer;">»</a>
                  </li>
                </ul>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
<%@include file="footer.jsp" %>