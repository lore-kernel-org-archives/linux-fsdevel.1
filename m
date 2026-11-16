Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794824553;
	b=RQjaQVr/nSMHlFhulmdW/77EvvMzBo43wstEA1ZF/8cbpL8dEKsaXbjKf11+YHdWvuDo
	 yKL/E3BX7LrNnpA/Ma2d90IRSmE/7GcSzvTGRiIKgD4lFyG75usMVTp6sugLn/xX+h3zb
	 jhM/vtrnfIHfHzgMHxvYzCX9MCkxFGuE1yyZkWD1pc3Oet5dHqTuBJZjA0oqoo1sM3Bh7
	 H8MZuJt+gJf2mOqfOAtqKMVOjdYVANoBNrlSfGJMLt8iwtmqjuFbjsjtheS0ugzZIX6b1
	 oB9m77W39rStnhw3USqUyYOyzPYiMY83WL4FQ2Xn36e+8mwHNvtOxZN5ZP9BEVHe98w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794824553;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=e4Et5WMZaz3LvBfh2jlwetoJpjp7/FMRj/wZQ24Y5ac=;
	b=5hDgWC1HwmSdJQwrZtVKlvszDIat2XOxyyG/BoFbwgmhJx4xgo8yTm/Fow8TQD0TkRrK
	 lMyeI0rWGyibucW24e5nOM9l4QjkWzhefzRlf0DrEU3DHnnbXbvT0tFm2yLy37sP+tVgw
	 ZR9ZHmTeYCYo8cpn30A0ZSwTOXVlSNEE7lORcVSOpcC0h8Hki8pOiAZNpyOXg7gFt4kRg
	 Nh6U55nf+CnDSCHhxjlXkWAeEIqdbc4FTO2YPi8xz43YTV+rowA3UGri9QVWHXyrEIGjN
	 5q4LdpDk3kODUBWUgQmegFIeCRB1tXiEZJUjTL2WApbiKjBW9IMpeL3XfGsu/UAY9AQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="s/kR0OQn";
	arc=none smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 730CD606A329
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Nov 2026 10:22:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 730CD606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=s/kR0OQn
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4bb72b44a97so4442805e9.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Nov 2026 02:22:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794824552; x=1795429352; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=e4Et5WMZaz3LvBfh2jlwetoJpjp7/FMRj/wZQ24Y5ac=;
        b=s/kR0OQnus/ELVQiXFewd4uRT1KvhI1DQz+VqaFQGfniIyQMOR1o5uLW2K8BMtcALB
         ZIL1cVqva+DwH+G3fXeg+CDR2u7QUVRzeG0ru8KZ4WBQhUdvVT46fHws81P+V+cEQ8pa
         Z3UvjQpJ180F0y26nlY8U5/nab+Hnq/c77dCza1EnXDbyNirk3maJ/xV3uIRZrOFPlA4
         xcE6rBIYl1v8qEqEhwY7mSuE/q8oOzQWXB3N9xgO5KQ8Kn6+q2RRIiemb3Y1haPJLFuQ
         ZRRtjb+oETeTgM7wFR66EYF9YSfRzphGrW/bDPwsibAAYPq9tbZeiG1tB08/MJeQpv4X
         DIOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794824552; x=1795429352;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=e4Et5WMZaz3LvBfh2jlwetoJpjp7/FMRj/wZQ24Y5ac=;
        b=hVC5BsuBzyo3sgtVu/ch+M+f1S/IEFTRD71gQBPjBPLMiFdxTvmBx+9hlkrYKWiOh2
         INE2IN6702SVz8BLKEhENfGfiimRR27NLH8c58AAa4MZ01dzTWVbODqSLHtg271rP2l5
         vsSCdMQpkiO0R2SkRLO3UtL3r8JWM2jLJ4CjlfXiFvmaG6i/sjrnWPO31MQw3LFHM9pX
         gdsjmEGNYFhAKbrnkATBt7ybCozGaAAeUsobWSwUKH8lXzH4saeLGLuDt8/jORny2vCR
         SxVJg8tSMBxZSIGS3RjDpGhhp/iaWZtr/PJGb84mEbwNkb+hatDFy2ezGggQOH+wL7Iz
         yveQ==
X-Forwarded-Encrypted: i=1; AL+hErH7iej/AT8u2z5rUFzKOqRWl81uWVcEYxg8QkqYyltXoExe3W2c4z08yeV1/I2h+WvxGwEwFXcuPOvlslYQ@vger.kernel.org
X-Gm-Message-State: APuU4Z+jI10+jayCCIut+frjXQnYLUOtg5Ia+3RFGDSqGslK6kXbZZm1
	gMJWdjpkFhJGg6cCC9EG5wiGlbfpwRrcUQqV5G3gLfLFpme5H1yi/0QF
X-Gm-Gg: AYBFou0cg75IASCgpxC5wT1lwRaxlN5oh10LZymxHclPWaf4VZd3YdNCHz608fA6snv
	pZ+I+95cyrIgHMXUP6bngqjuTmt2bPym5lSg/RPrA+WBGkj4hsSjs8pnZZeIZw/hNuurSAi2EI0
	UcT2m/teBeU7xwfuh5czJxqHcFWT3qOiSfJ8sxQwSfPjxJ3ly3YjULvtq7/fmU3QJe/3JCeYv5Z
	vcExytiCl0Jf4lMioaTTWy7sNf9lrP2rfKUdaxv3aZf4zgemQA1DTf5cf+8RhmT6N4Ry17tcOSY
	FxEJQgHDqpKvF8ePUk7xEZ571or6ttx61iZjkKyn+MH89of1pnQk50zHdrLjoNQdYS8fRdifRL9
	AqSAxx5PpmDjq6FaVEYwz9/OSZSHFAdnUNIoRyMU9bsgIi4VV8vM8TRp3BZLNyEYMjJhtiDdD6l
	ddn8++6HWlpyKfF043RKiEorhsYWeDk2A+Aw++fu3BKC36N1pvyRYElKTuHv8xJQm7A+HlqJ3TG
	IX2sbU4Vi065SpsLP4OsTfKOWybfSpYONYI1KBdB0G9+GphtDG+3bgOxCkklXBq0ufiYv770hva
	GvR/pHIzAwcQMPhHhFWk
X-Received: by 2002:a05:600c:34d2:b0:4a1:fa27:df7c with SMTP id 5b1f17b1804b1-4bb55ac6cabmr206158025e9.34.1794824551582;
        Mon, 16 Nov 2026 02:22:31 -0800 (PST)
Received: from fedora ([5.131.7.59])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb4e2adf53sm388703845e9.15.2026.11.16.02.22.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 02:22:31 -0800 (PST)
From: Petr Vaganov <petrvaganoff@gmail.com>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Petr Vaganov <petrvaganoff@gmail.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Su Hui <suhui@nfschina.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH 6.6] fs/stat.c: avoid harmless garbage value problem in vfs_statx()
Date: Mon, 16 Nov 2026 17:21:58 +0700
Message-ID: <20261116102217.80740-1-petrvaganoff@gmail.com>
X-Mailer: git-send-email 2.55.0
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

From: Su Hui <suhui@nfschina.com>

commit 0fac3ed473dd2955053be6671cdd747807f5e488 upstream.

Clang static checker(scan-build) warning:
fs/stat.c:287:21: warning: The left expression of the compound assignment is
an uninitialized value. The computed value will also be garbage.
  287 |                 stat->result_mask |= STATX_MNT_ID_UNIQUE;
      |                 ~~~~~~~~~~~~~~~~~ ^
fs/stat.c:290:21: warning: The left expression of the compound assignment is
an uninitialized value. The computed value will also be garbage.
  290 |                 stat->result_mask |= STATX_MNT_ID;

When vfs_getattr() failed because of security_inode_getattr(), 'stat' is
uninitialized. In this case, there is a harmless garbage problem in
vfs_statx_path(). It's better to return error directly when
vfs_getattr() failed, avoiding garbage value and more clearly.

Signed-off-by: Su Hui <suhui@nfschina.com>
Link: https://lore.kernel.org/r/20250119025946.1168957-1-suhui@nfschina.com
Signed-off-by: Christian Brauner <brauner@kernel.org>
[ Petr: There is no vfs_statx_path() in this tree. The fix is applied
  directly in vfs_statx() by jumping to path_put() via a new out_path
  label, preserving the reference drop and the ESTALE retry. ]
Fixes: fa2fcf4f1df1 ("statx: add mount ID")
Signed-off-by: Petr Vaganov <petrvaganoff@gmail.com>
---
 fs/stat.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/stat.c b/fs/stat.c
index 5375be5f97cc..9d3f1b276c86 100644
--- a/fs/stat.c
+++ b/fs/stat.c
@@ -246,6 +246,8 @@ static int vfs_statx(int dfd, struct filename *filename, int flags,
 		goto out;
 
 	error = vfs_getattr(&path, stat, request_mask, flags);
+	if (error)
+		goto out_path;
 
 	stat->mnt_id = real_mount(path.mnt)->mnt_id;
 	stat->result_mask |= STATX_MNT_ID;
@@ -262,6 +264,7 @@ static int vfs_statx(int dfd, struct filename *filename, int flags,
 			bdev_statx_dioalign(inode, stat);
 	}
 
+out_path:
 	path_put(&path);
 	if (retry_estale(error, lookup_flags)) {
 		lookup_flags |= LOOKUP_REVAL;
-- 
2.55.0

