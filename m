Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=54.206.34.216
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793104137;
	b=ikXVMIWk778dwHj5Dpp3u2U1zKjJ0L6EgSBkzHwZEW2LmZwc+NmRHwv3RMOVlKYoIEqu
	 +t0UrqfD0MT/HP8fECA3OCxRUw6NzVFgvZ8ry2m7QGlsnFYOVjKl0vjtI0RUu1x1Dejpg
	 abB0SgRp+FIfCjzDGZNkxqOkCNTta7nW9yukakVvtJP4JzT6AbOQjPvnwvK/xkG9Q35nJ
	 gD2d6Zf6J+VjP0wGzNNo2kj80F5mFf2ZrOLBrQUR+ckT17ve5elCzBIpBR4jFZctMlEOi
	 rGk5wFqdSigFdxdda8Z+wKzguK3b8yoISR8bobL+8unyp2pE2aCQw/8S6JcqScO4RRA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793104137;
	h=DMARC-Filter:X-QQ-mid:X-QQ-Originating-IP:Received:X-QQ-SSF:
	 X-QQ-GoodBg:X-BIZMAIL-ID:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-QQ-SENDSIZE:Feedback-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:X-QQ-RECHKSPAM;
	bh=AEbQPUbB9L5csU3Qby0gIRmmzxEcw2PR2rmehpt0UgQ=;
	b=d3H88bXezmOjTeaA0weKScYZSeJ7HqPDW5dm8wkacj034AqB5QwwgOZYMTVWNAAY48fV
	 21LjOkYClBHOOhszOaMFCoPZ+MpKFPWx8cpZr8BjUH0nQUwFcGcEQyJSnrNbFF+ttta5g
	 BN1+xtmOOSInNDkWgn8HYTSoaW3icm+6fm2npj73nana44VS1kPw9MVNlBOz+Op3QBSrP
	 UgIFrvulxfa+paTtvnphOCcb+ylToQ7yV6Qz0tpG5jwNOfV1m9MmUA0XNWFGbDiykV/RP
	 X6HE/XDQr7JL6SZk6k78GS2pGHK6+fHAZEGEC7OTosnL05QeKEHifCwF1cUI+5ufkcQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kylinsec.com.cn;
	spf=pass smtp.mailfrom=kylinsec.com.cn;
	arc=none smtp.remote-ip=54.206.34.216
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 675FD60A2601;
	Tue, 27 Oct 2026 12:28:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 675FD60A2601
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinsec.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinsec.com.cn
X-QQ-mid: zesmtpgz5t1793104105t0d6b75a0
X-QQ-Originating-IP: ssmT0s5kl5UsItt6FKmeg+RWndKvUK6VSSrNsFFxkyA=
Received: from arch ( [175.0.204.93])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 27 Oct 2026 20:28:24 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 4551890927755228024
From: Luo Qiu <luoqiu@kylinsec.com.cn>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] fs: fix typo in do_open() comment
Date: Tue, 27 Oct 2026 20:26:47 +0800
Message-ID: <A977B5B944F3C7C3+20261027122647.1837472-1-luoqiu@kylinsec.com.cn>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:kylinsec.com.cn:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: M5znx2hx04lbtqUiS/Sx8GgjzU7o1/j825AvUCi+6ZovQ15oqGJIKa84
	FrZj3rX6zIbO2sCzIQUyPqbOoNDcQGq8iiEzoQ+U1LB7YOMguTNpa4keRAfRzECfdi2fc8c
	/32tDGqjur1QiErHgZ0miLjffWDy0lC9a6WQj/mw1Xjje1A7knKxSuB/NsfKvhYeKtyUy58
	LQwwlO3Gdrni/Xx8VRvGwDeFh9fFLzmMI9wohO7BC352tf+G4G9ti2l/KBNKmp29oeqNsAF
	i85/w12+NHrCWoT4ybtfiASgh7n9sr/vEy35aPfQmtTJ/9+mtEO3PfOc8SAWJ8yzRZ+nRyH
	HZBbwW+ihlb+Mu36NOTKpeS73aQSuKDcWMK+pQRjWiMDcls4Gdj9Z7NcUoAGMSS63wCEiPW
	gVvZ7Qsapld4npST8vfDiJkHGbCnkh1VpM5M8W8L2+zphSqinj50uleS4Hj/VAJWOVIN4XN
	nbA4fn3+Bb9/kFaamwRDFJOolqg8yqNqp0yuy3pzbdu55cJuRqEjlJBhk0ArVhltSRA4p+6
	PlwznofbYiyBQVzqDyiWTKyMsTHCRP1o5K8WhFYwUGuEKdcSfJeWXaPfEKHVImmKrFi3CHh
	A2sfBjgjXIR1oUCNgc9PB1mUqbdqXmnUZPLT3tQTIkgCLX+z+7Q+ipvhSFOOnm6S6+YUl1e
	rjd0R2pWetm0hJeET1OKibwXKjPfSsps9ENtcGM2KaKvr/r5I1Sap58CBJs/nszh+oT7mDt
	KOrKSEpy5deBSFfbJ7Rlec6WOhTWhSz3fBWSpTpCZUa5iu1cFe+ez4Y+ZDY2gVarpcVz/c8
	Lc3kmwdJh76CPemEnosrvhvyxcep6LDQhWoSs7y6vpJIZYIRayIuzGIkveeLTVMsJrCW5jc
	XdiOr9ztQAhaKDMwvFj5h3Gco9bvfr7MkmfmHAJMp2iXGbAxy9r8vJykDyqN73b8AtWj6zi
	gwiX/3J+bI+WSQIoAIBRfOMEFZZa/e1rirL03FpyAerFV5RBPZcdY67TVc5asFdxFaedEsJ
	ZThUmpjNEV3vtX14gKzcJMipfz5QU=
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
X-QQ-RECHKSPAM: 0

Fix "acess" -> "access"

Fixes: 161ce1e692d0 ("fs: avoid spurious dentry ref/unref cycle on open")

Signed-off-by: Luo Qiu <luoqiu@kylinsec.com.cn>
---
 fs/namei.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/namei.c b/fs/namei.c
index 96c65940391a..9bf97d5ce37e 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -4835,7 +4835,7 @@ static int do_open(struct nameidata *nd,
 		/*
 		 * A dedicated reference is needed because after the call to
 		 * vfs_open_consume() we no longer own the reference in nd->path.mnt
-		 * while we need to undo write acess below.
+		 * while we need to undo write access below.
 		 */
 		mnt = mntget(nd->path.mnt);
 		do_truncate = true;
-- 
2.56.0

