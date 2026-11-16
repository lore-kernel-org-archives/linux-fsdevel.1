Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794824592;
	b=DqJw6a1cg0uyzm1NcRJUNpAc4b6RPD57Ki76uy7lsc5ICpVGilhUJj1+cEA1lEZk+Gp1
	 Ibg4r+7gefGrlvzv7mdo1qEad9plC2D7Hf07gxWBsecPdPZl8/bq6TuGIT7fgTSEr1ZEg
	 ZHjXBqTy4/1YEgIDgco9OUrCGoqBc7MlnPCVp4CdIhZmWH1+Ilawy3BoO+kBHeY7BMo5a
	 gdMwoeei+hQzsX0TssgiM8dZVcc2BaNW/lY2mZHGZ/cS4LPPEojfYb8uQuyCJb0MVSbep
	 i65dwQ++nxZ6Wj3oJcRg86jYrD/VeTfJ+5eXGEGbehTVcRRUBrGx4+4PKLCk4WhMFVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794824592;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=+Z+9Ajv3xyJmoB5H/8jTZN0dMUeUUYatOho4V13GL9o=;
	b=nRdDwPBVgcDTjdDzuGvYo/HRiv5xQF+A6ImtTMakqlPj2piXogyokFBv87Sg6kLQ2RDi
	 Kk4JWsGZwog+VcreGjiCg/ZYQqQADTc9pVL8FvJMYJ6VsYt6avcaINr27wy1vnl95GGlp
	 6eT/LLz+vEpPZGQs4EOgy8jPR/V4tcwz13m4VTDyc9JLTpjp4uvp1YYzje+WKOA1iGvys
	 5zeE7ZIB43KbNuPLlKoQUX54ytW6dNXBW7EV3UoqBCtwxrzYVwaAtCxw3ghGynUYPiUAo
	 SkQDElcmU1GiCv/stqDXsP8T378fFYbq9xHY9J/ocixueLAjBN22i1Qpd/oKKJ3aHKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ev6u7bg8;
	arc=none smtp.remote-ip=209.85.221.43
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE9AB606A332
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Nov 2026 10:23:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AE9AB606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ev6u7bg8
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-49134c8509fso3228395f8f.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Nov 2026 02:23:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794824590; x=1795429390; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+Z+9Ajv3xyJmoB5H/8jTZN0dMUeUUYatOho4V13GL9o=;
        b=Ev6u7bg8Rg6ax0mUmXVgVdgStOD9C02I6qEPYaG4s5jtP3kBSQusRYR8OpFgMtqrJk
         SHmmYBCTGWQEkdqzKDbfOxUQVyRN06eWBZ3f/Q51vxVY3uG8G63Ez1X5Ak1gqv+wavEN
         Ef9Rmo2JStYusMZhkn6y86mEkoDtW2xTpc3qyYnaMCRFFNFa0V3B5AoaHQHR+4mhlT2d
         V0iOsCk10x+roDEejTdSyoyWmUlaXfMITEFfybEp+sd2hMZCyrQBa7arMdYGUkfS/7M3
         A2O8SkGvGrsd+zNB8NVJqrUTumuwU9aVa3sZxX3Fn1VZlWrC8CsgaZ6gCDFR8n4XmNQf
         MOYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794824590; x=1795429390;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+Z+9Ajv3xyJmoB5H/8jTZN0dMUeUUYatOho4V13GL9o=;
        b=F37QiIxh1AXW0LlQfYyBesWEBiTBPpU5OicgtBBy/kev7Z1VvQYf+px6QUUU6pSGoi
         FbwDAjtlxditYIQUK0CU5rxb1PcidxTRXw50V7LQPMlP7GBgA4uYic/ustfePrjYEti6
         hfEYDMrsAbbDHf/g8VzLoHjygoNrF20LWYNvcwQ7+pSnGJ1vTq3IgnGw2f/Yr6D+BxtM
         OnIp5M2/fdT5XIEa69YFQpNuIhab97zPxOwrhwCIqpo2TOiOZtccx6J4AmvGLHi4jLfN
         7gTmnsJYPQTTgK1jRVarcczPFGaEWlT4nir8hjoPxvsdPV48tSsvGiRNVI4nTRMEd9G0
         6RHA==
X-Forwarded-Encrypted: i=1; AL+hErH25eiPqMAsuy0JolMVYkDq4NqZ8evBbWz/ZyPSBO1blAUySJd1+xfh2qWn1X7HhD0zDHPpgiu4EcdPPMWy@vger.kernel.org
X-Gm-Message-State: APuU4Z92sjWvknUqwft4IbRPQzd5TS4scc/+Pd32WcvQP5eCOblF9DP8
	eUsu/w1Sn5JMyndIflwHywi29ZjLg5TwKMuouU1DmEodEaAAgsCbYPaj5jN4vEBe
X-Gm-Gg: AZFdTZd+6hJjy8p0cACrBbwLiRQ0ITOwUYongsDVzALOgS5ETUfXT63mBGIt3YBgRve
	VCTaUpuzR9M6NvTXwlmuDiCEyrbSwTq7/EMpbqIpQ/0gUiQoqM3j1E8/+CgrkYOaUW+W/1d7nTc
	ESrnOzu6i0z0AX6qn9MTUqWaoQ9eO+0t6vvdEOSCswzNB9Heowu14V5M/WQhF3318MA6Wn5Oi2Q
	6F1kW4tNLDfwRoNUE9q4VbOeIP8//ebcRGuMbaO8+PcYwSz8CJOBCMq1WwriLosbn7ti9UHratx
	rCAmo3IiBnA1ai+hKinfHFrRfUrez68fBxd6BSXnEMbXxKDObTk/322upGcPDLulRJQbGTaZMpj
	SB1Rn9xppY/G+sSKgmQNxJEjsM9ef+KbdSA2NYp8K8HVfVsMlkrM/zQ2EJztGhiURVefsDPvNq+
	ybYKob/S4PPQEIn4ZKzCjQK47oorRYaww6XCfPTSfsXdcObOW958zhb36k4AGTijlEUtNBxHy9y
	q0pvcHW73KHKubg6rl3JNGCU5+9dhWiEz1N6/A87bPYkW3qKjRJvKTP3IOo1/hWvBG9o5MWwG1y
	rkCpwI0ln9n7E5CkGuLlcDquPxWoU1LYRnQzN4pBK20=
X-Received: by 2002:a05:6000:144d:b0:492:880f:494e with SMTP id ffacd0b85a97d-49c72c9c630mr23730288f8f.40.1794824589695;
        Mon, 16 Nov 2026 02:23:09 -0800 (PST)
Received: from fedora ([5.131.7.59])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c608c5debsm20788426f8f.42.2026.11.16.02.23.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 02:23:09 -0800 (PST)
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
Subject: [PATCH 6.1] fs/stat.c: avoid harmless garbage value problem in vfs_statx()
Date: Mon, 16 Nov 2026 17:22:55 +0700
Message-ID: <20261116102255.80986-1-petrvaganoff@gmail.com>
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
index ef50573c72a2..bc2b1f3a3860 100644
--- a/fs/stat.c
+++ b/fs/stat.c
@@ -231,6 +231,8 @@ static int vfs_statx(int dfd, struct filename *filename, int flags,
 		goto out;
 
 	error = vfs_getattr(&path, stat, request_mask, flags);
+	if (error)
+		goto out_path;
 
 	stat->mnt_id = real_mount(path.mnt)->mnt_id;
 	stat->result_mask |= STATX_MNT_ID;
@@ -247,6 +249,7 @@ static int vfs_statx(int dfd, struct filename *filename, int flags,
 			bdev_statx_dioalign(inode, stat);
 	}
 
+out_path:
 	path_put(&path);
 	if (retry_estale(error, lookup_flags)) {
 		lookup_flags |= LOOKUP_REVAL;
-- 
2.55.0

