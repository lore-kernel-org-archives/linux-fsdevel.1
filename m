Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794320706;
	b=e9T0GuB7VXab5d1UgZP5VGiYXit5kLwx92BKAjpmkXo68wmAJ2/Tw01M2ee9uFishfYa
	 uB1IdtXBzJvSt7QJZfws2MOFR66z+m/jgqVf/KRbsLDGErN88X9S6OGLyGz/yKvajsu/L
	 Kzd7fpp4+5bSgTaJGN9foGd1G8v+HO1al3ZOvKlbt8U8T3rNdfBa2nDi4KQy0h4DLw8SO
	 5ywhDc12uOV/9R7xSYF/+F+t3OaGLhCn1+tKE3QesfinK8jo62wx6rbNFffMMN7INy+RO
	 sNDRV6aR8GqYoG6/Owx39krRY9xKSBaTfunfo+ZRuPL3mFkbCax5P5Vcl3WCPcYUSog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794320706;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=fsgc145zwHET8lvApLf2hA0PKAQBWP1kvOH0cyQnSe8=;
	b=NLRKgimcXbmLv0waT5FbBYLdQCy9kzEFZmRIQqjEj1OAMG9yWCSxagbQVnyMb2gHc3M4
	 DloWFuL2C4/8LF4TYN+4cKvA1uXcw/oF7XbgH1kFoo6s9cI/yOXc25kuuBozKfqrVbTOj
	 ym7MisMxoJgAuvSey+8dRbDAvIN0BY87CoUSDPhqY5GQjTbbFHUJyM2FyNtu4zir5YB0i
	 FaOEweVCDxp3O/3DeengGxYkkSi+TPqcPA27tBM/Xs36NXlooceb/vGquen01/EQ/L+gs
	 QGPD6S0IXbuejQAAXSAsDbqyO5iEIQIyvoeOVMYG1+ww3TPGDzxGrDI04egF0ocVdhQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=KZ4ymSmw;
	arc=none smtp.remote-ip=209.85.219.48
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 052EF60A2611
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Nov 2026 14:25:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 052EF60A2611
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=KZ4ymSmw
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-91eb5559b34so15770446d6.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Nov 2026 06:25:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1794320705; x=1794925505; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fsgc145zwHET8lvApLf2hA0PKAQBWP1kvOH0cyQnSe8=;
        b=KZ4ymSmwGQcTSEAG9tjuCzWtnNUBwSexP7mH4b7HisT1MmvhMnZkOsziIulTO8Zf3G
         pOAj8szA8/crd1BpkZnk4l7YKy1uaAaXtqsuCS6x2h2EVq2A6voMlZaZr/HuDPczmxEM
         e1J9Tp2fBo/7qkEOh0jXe345pHG+Qs3yL9m5y/SQUPLP2SMHajDlBC5OgVkAb3V0a1I4
         zwJMbbTKC3dTad5Cz267m2JvbO+C3FJmLz7UP8CHNCi7DCtNmfYtZ8byKNEPT2F9lxix
         QYd6KYHJ+qHhlAkSwLgp2vNVyBpg2+FQb1328ZtZaLXxO1mXZ+LX4+JHO2zjlFM4i3I5
         qrIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794320705; x=1794925505;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fsgc145zwHET8lvApLf2hA0PKAQBWP1kvOH0cyQnSe8=;
        b=HYpmrhn0gaNbZvXi+pjs2gNfx5xOEL6E8WBQBeZy2KIl0wV0uAnE44AH+77Yd25IOz
         eFYnkpCCea2Z/SQ6GyKgGl7yTJNb1tvVVvmm65YJTFMVScGfF/qsX09YXr9wjFQfiyeG
         FCqUCafVWQc09P2hgWeSF3+8qeA5J1rGqg7u9S65dzSrGlbtH1FrQQ6wJKDC+/74V8Xe
         WNejvTFCTtVTv6Yzx1JjlohOxh/aFgx8VfbrMkbBoPio8E+t4r9lpZP4GPh4IMks/hEt
         XAmWIUkEYBIa0I3wn1ZteTDhjqbKHnhHUN8FcuRccK14ioDSszDWB7Py7NvUpZINbO/k
         Q7Iw==
X-Forwarded-Encrypted: i=1; AL+hErF3PB8XmPNZdiT7ah1NluzTfYxJQCk+Yw/SV21PT61tSmNnj/XrIcRqLUBly8sSVC/zEH2Ut80BHulfgG3J@vger.kernel.org
X-Gm-Message-State: APuU4Z/n350oxhZc5XUb0aF7yBgA9h97gTZEGl3brOSKR70nWHF0Muz3
	ePUUHWx6Js8amFUHlLQjvjaj2M4LqjF4lTNeGesxYxA8uY/dggerj3ke8gg2XrXblLk=
X-Gm-Gg: AYBFou3fwb0whkpjeJo/Z42VuTU24+zzo88qdbJ5DyIx7Z/ZDuX4cmvKXuEGsmOXrck
	OkaBDlp24uZl/l42uV4n9P/TUWm+UuWq4jIBuCvEikMz/CuEMdrifnFw3BwGpsssrE73hWXFJNF
	HIlMfKCWtcwWKpn1AKqMSSxEtWORW6Kc681qgT2K9sr2Xs0THuXEwUJqioe5PLpKboZgwwGjP8S
	2sz0osseLzwU8kscyxCg2+dSyjA1TMz2Lo5Eq7jHLjskvJfCK/8r/KW9523Wfnpz7VgBw4+kNgS
	7Wqp8meTVnxL4NQlpUMTbKZT9WyVhc8syUqsMEPc5EPkLGQkwHMNu1nJ1nNHGnlCseBvFDB1TRt
	idaPGS2C9XhaaEOPViVXLdqGM4zIZd/efIOlXInZqWGHHOyYTzx8zK+wA5HpIm9Z+b3DEofQEGJ
	DCooCWKq1buwdMZccoxsESRLXrz9AMjqOd0HpcCnQ+gZxFb0cUdZ/W2hcqP2DKVCJ3bwWxt63jE
	ng/ueVJeiEUhedNwalzetkkqWwAfZeMA/rbucJqfgZJXPxP93j78JKzhFLO/21rSFbhmShGp2Jq
	17MRnZdx4+AhNs36YI8UhETMUPVt8EHhyKTUYCJanWqV6Q==
X-Received: by 2002:a05:6214:1d0c:b0:91e:b7fd:b35f with SMTP id 6a1803df08f44-91eef8e19d0mr46530126d6.30.1794320704691;
        Tue, 10 Nov 2026 06:25:04 -0800 (PST)
Received: from toxicpanda.com ([153.61.196.252])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91ef04fb5c9sm22263976d6.24.2026.11.10.06.25.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 06:25:04 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
Date: Tue, 10 Nov 2026 14:24:51 +0000
Subject: [PATCH v6 3/9] ovl: setup overlayfs' private bdi
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261110-b4-ovl-containerized-sync-v6-3-43d1be16a4d6@toxicpanda.com>
References: <20261110-b4-ovl-containerized-sync-v6-0-43d1be16a4d6@toxicpanda.com>
In-Reply-To: <20261110-b4-ovl-containerized-sync-v6-0-43d1be16a4d6@toxicpanda.com>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>, 
 Christian Brauner <brauner@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Christoph Hellwig <hch@infradead.org>, Chris Mason <mason@kernel.org>, 
 Chengguang Xu <cgxu519@mykernel.net>, linux-unionfs@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Chengguang Xu <charliecgxu@tencent.com>, Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1794320698; l=1000;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=oigsy1vUIPeqGe01IWwnaOrpAKAk76udNuQNtC58Mj4=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QM6Qi2Z/vttC+ismRUqZpKJCnEVi+EA1CDQav1wZ91mZcSHpYI4N/AGPLItarZUhdimNLf1Xgkv
 0yxrYcudV1gQ=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

From: Chengguang Xu <charliecgxu@tencent.com>

Setup overlayfs' private bdi so that we can collect
overlayfs' own dirty inodes.

Signed-off-by: Chengguang Xu <charliecgxu@tencent.com>
[josef: only for an overlay that tracks dirty inodes]
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/overlayfs/super.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index 81da70fd53a6..22a8d4eb3b7c 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -1490,6 +1490,16 @@ static int ovl_fill_super_creds(struct fs_context *fc, struct super_block *sb)
 		if (!ofs->workdir)
 			sb->s_flags |= SB_RDONLY;
 
+		/*
+		 * Dirty overlay inodes go on the lists of this bdi.  fsync_mode
+		 * is final once ovl_get_workdir() has returned.
+		 */
+		if (ovl_tracks_dirty(ofs)) {
+			err = super_setup_bdi(sb);
+			if (err)
+				return err;
+		}
+
 		sb->s_stack_depth = upper_sb->s_stack_depth;
 		sb->s_time_gran = upper_sb->s_time_gran;
 	}

-- 
2.55.0

