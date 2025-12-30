<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="ko">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>리뷰 작성 - 망머샵 미용실</title>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <link rel="stylesheet" href="css/review.css">
        <link rel="stylesheet" href="css/common.css">
    </head>

    <body>
        <jsp:include page="/layout/header.jsp" />

        <div class="review-container">
            <div class="header">
                <h2>리뷰 작성하기</h2>
                <p>이곳을 다른분에게 추천하시겠어요?</p>
                <span class="shop-name">망머샵 미용실 인천 부평점</span>
            </div>
            <div class="content">
                <div class="user-info">
                    <img src="이미지 추후 추가" alt="Profile" class="profile-img">
                    <span class="user-name">예진0928 님</span>
                </div>

                <form action="reviewAction.jsp" method="post" id="reviewForm">
                    <div class="form-group">
                        <div class="select-wrapper">
                            <select class="input-field" name="designer_no" id="designer-select">
                                <option value="" disabled selected>디자이너 선택 ▽</option>
                                <option value="1">김조은 원장</option>
                                <option value="2">박한별 디자이너</option>
                                <option value="3">이민지 디자이너</option>
                            </select>
                        </div>

                        <div class="date-input-container">
                            <input type="text" class="input-field" id="visit-date" placeholder="방문일자" readonly>
                            <div class="calendar-icon" id="calendar-trigger">📅</div>
                            <input type="date" name="visitDate" id="hidden-date-input"
                                style="position: absolute; opacity: 0; pointer-events: none;">
                        </div>

                        <textarea class="review-textarea" name="content"
                            placeholder="리뷰를 작성해주세요&#10;&#10;리뷰작성)&#10;서비스, 가격, 분위기 등이 어땠나요?&#10;사진, 동영상 첨부 시 더 큰 도움이 됩니다."></textarea>

                        <button type="button" class="file-upload-btn" id="upload-btn">사진 첨부하기</button>
                        <input type="file" id="file-input" accept="image/png, image/jpeg" multiple>

                        <div class="file-preview" id="file-preview"></div>
                    </div>

                    <button type="button" class="submit-btn" onclick="submitReview()">리뷰 작성완료</button>
                </form>
            </div>
        </div>

        <script>
            const calendarTrigger = document.getElementById('calendar-trigger');
            const hiddenDateInput = document.getElementById('hidden-date-input');
            const visitDateDisplay = document.getElementById('visit-date');
            const uploadBtn = document.getElementById('upload-btn');
            const fileInput = document.getElementById('file-input');
            const filePreview = document.getElementById('file-preview');

            calendarTrigger.addEventListener('click', () => {
                hiddenDateInput.showPicker();
            });

            hiddenDateInput.addEventListener('change', (e) => {
                visitDateDisplay.value = e.target.value;
            });
            uploadBtn.addEventListener('click', () => {
                fileInput.click();
            });

            fileInput.addEventListener('change', (e) => {
                filePreview.innerHTML = '';
                const files = e.target.files;
                for (let i = 0; i < files.length; i++) {
                    const file = files[i];
                    const reader = new FileReader();
                    reader.onload = (event) => {
                        const img = document.createElement('img');
                        img.src = event.target.result;
                        img.classList.add('preview-item');
                        filePreview.appendChild(img);
                    };
                    reader.readAsDataURL(file);
                }
            });

            function submitReview() {
                const designer = document.getElementById('designer-select').value;
                const date = visitDateDisplay.value;
                const content = document.querySelector('.review-textarea').value;

                if (!designer || !date || !content.trim()) {
                    alert('모든 항목을 입력해주세요.');
                    return;
                }

                document.getElementById('reviewForm').submit();
            }

        </script>
        <jsp:include page="/layout/footer.jsp" />
    </body>

    </html>