Received: from mail-pz2-f40.google.com (mail-pz2-f40.google.com [74.125.228.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E305505CE
	for <linux-fsdevel@vger.kernel.org>; Tue, 22 Sep 2026 14:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790085705; cv=none; b=Ln8V1rhGLowEzYgHIoVQ//rYq47NW+KDa/P7y0KbxlSfq0UGQSaDBbToQMhtthdEy5tuOf39cD762S8zzf2sA42+mQRJ5XSe5VdF2Qx+SnPVekAuqGzaPLT0a5XSRJYkqwb5k/LErTcbrEmpy6fnFsbXGI6S/odNwbX5BIDoZIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790085705; c=relaxed/simple;
	bh=Z0x5CU2E73GGQT0WGdYVgrKEzFDVlQaVuFg3+JZSUvw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fqG3KgcE0PeXq06G3R02O8ZMDpsKjMqGqGY7BSREkzHpNlrFSPOTLmXJQTSKbbaQbV29Fyjyve+hJXP0h28nw9MgyWx6iXZslKLAvsDwKBVidVvylMVUdNsMerl4z1XxA8btyZojr084tIsqezt0Z06+QEFyvVadiXmHeDbShHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cm3jTXUW; arc=none smtp.client-ip=74.125.228.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cm3jTXUW"
Received: by mail-pz2-f40.google.com with SMTP id d2e1a72fcca58-87ac7657a24so1084310b3a.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Sep 2026 07:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790085703; x=1790690503; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5oGWhynSEKne6RN1QxHEC9k9P8vjg9REo1kgWqBAqDc=;
        b=cm3jTXUWDShvamxv6PLkK2K6Q9MB4rEk+cAcGymFs4WwuepqrzAEbb2masvMl121wA
         W/BnezkUy1olSuw4M+vV01S3/xO/HelaHrcRLHpq6zb3DN+ADEqFqjAPLv38QO5ExjR9
         oc58I81SoQAcEvorEif0qF+a9cKLFX2j/h/cl//a8iOz1NvcudBwXhiKkb1SXg9aaC9O
         8gCcro5Ydt9CnNUER5DPsolm3YfLlOWnhGsEQ6DZnOCBmZr9WYgcdb0myalLQdyfHho9
         4UHunuTCcrLRllkBpn90adOLN5VHVGy2siZGyAo79DRCBvr8+Gv+gH0gCMEhl+aclIdw
         pqIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790085703; x=1790690503;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5oGWhynSEKne6RN1QxHEC9k9P8vjg9REo1kgWqBAqDc=;
        b=vV2o8Yinek5ODJTulo1/913SMFStZeu2IS7cjNkXNHT2/5DHclQvoDqBt5aUtaS3AR
         1qcFMrBAUeBLXSiynYgZYgVrMvbVw8tWSMx6h0c9K0Hoo52AeQEiDxyyRbBDhr4q768c
         NOgTpBx8nXI0aD5urn7mXo6fnCO1JXh8Fpt8oLT3jvQpcnbqISQJLsGSnW8iOY47Y2r1
         GKqNMu6FKIREiodphaIfxZW5XM/iuWYABlHCi1ubUY1D7SIPLnq6mKdLiYRg9njR1C98
         2UJ10TQaKDS/BSBKnNJhBeQxn7PGMjwHvFGhx0UpEjk13MmovaPJLZmNjYdXiINOTRNq
         tVRg==
X-Forwarded-Encrypted: i=1; AKwUvBxIPbFM+Q2ZlgY42icosggfJ0SB+xiUAgTd9e1HC+Ab/+Mg9T1Mww6kDeNvzl6dhBA5QwuRcZv2yMZxa/6u@vger.kernel.org
X-Gm-Message-State: AFuF++mXaUEAZn48IVftoIK+WKrcX9Zt6YmWd2dub3FUCqqMbbrSIILq
	O4aX1n82rI0LYf5yK8KRw9wpy+52A0KpYo6VYZthpPdbnHs40ps46UNA
X-Gm-Gg: AYBFou3rt8A4137TBIZu+C9zHg6hkrTOAlrPoYJ1ake4dUnuu0RCGtoKo9CvTnhrVYC
	ETdsFWl1R/ZsWMDdWDJSa8nqpQpOS16iuxflLCi/FqnVZyZrocc2VbquOySQZ6nnnlD3YWL4vgZ
	YlqW6zOEjUlXsBQnRgq52H4PtSw08KMG11MWZlVwpTK7KN/otsP5bIQaLrGfZSceL5GGh2CAa58
	SbDlcvWFYMX2eoeNgO0J7tOYTryfuvZlvuh9/3ERWLcT6w+DJ8SOHz5FMXIh+bGtIMMCy6oJ+/l
	qeLSWUpQm+Ssamny9tWW+E2g6wfidrslbSnrwuHBNxzTel0F5uxi0A5RhNcsHl15/V8iCgVfHWW
	qR201WgaGWcPxmf3heBZ1del/qFve+ZPQV5qERWJ9EvYoN0pqGh8jxi83xkER66rkdHeWvJJzI7
	oU/Ovbgg/wF2vjfhkbEg06wfM1U80xy6LMDBsxL8XvMWyzOuiejU0Yn4C/YaYXWbn8bOFjSFaTN
	dKfMQbHTjf7ME8JIdRBBK7ODTWaj/6o2nmxtoRJVqHaOTv/0k/PF0NoZE7eKw0ETluqRfOHkHCN
	9L7uzu8Yvs22wmZvRDEyzT0KnDac0ibs9ew1XougMpXPymt6lcQowLIHj/z/Hh9Tj5fGCF7sDg=
	=
X-Received: by 2002:a05:6a00:1f1a:b0:878:37b2:df98 with SMTP id d2e1a72fcca58-87c8500a986mr1360521b3a.56.1790085702880;
        Tue, 22 Sep 2026 07:01:42 -0700 (PDT)
Received: from spider.bream-herring.ts.net ([103.252.203.158])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-87c329c813fsm932803b3a.38.2026.09.22.07.01.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 07:01:42 -0700 (PDT)
From: Matthias Goergens <matthias.goergens@gmail.com>
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>,
	Yichong Chen <chenyichong@uniontech.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] isofs: validate directory records in isofs_read_level3_size()
Date: Tue, 22 Sep 2026 22:01:36 +0800
Message-ID: <20260922140137.1768064-2-matthias.goergens@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260922140137.1768064-1-matthias.goergens@gmail.com>
References: <20260922140137.1768064-1-matthias.goergens@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

isofs_read_level3_size() walks the multi-extent directory records of a
file and dereferences de->size and de->flags for each one without ever
checking the record's length byte.  A record with a short length placed
near the end of a block makes those fixed-field reads run past the
record, and for a record at the end of the last block of a page, past
the buffer.

readdir, lookup and the NFS get_parent path have validated every record
with isofs_dir_record_valid() since commit e2ee4078ec58 ("isofs:
validate directory records consistently").  Use the same helper here.
It rejects records shorter than the fixed part, records whose name
would not fit, and records that would run past the block, so the
straddling-record copy below can no longer be reached with a bad
length.

Found by fuzzing fs/isofs in a userspace harness with ASan
(heap-buffer-overflow reads in isonum_733(de->size)).

Signed-off-by: Matthias Goergens <matthias.goergens@gmail.com>
---
 fs/isofs/inode.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/isofs/inode.c b/fs/isofs/inode.c
index 337836a0a170..c9bc1f479161 100644
--- a/fs/isofs/inode.c
+++ b/fs/isofs/inode.c
@@ -1208,6 +1208,14 @@ static int isofs_read_level3_size(struct inode *inode)
 			continue;
 		}
 
+		if (!isofs_dir_record_valid(de, offset, bufsize)) {
+			printk(KERN_NOTICE "iso9660: Corrupted directory entry in block %lu of inode %llu\n",
+			       block, inode->i_ino);
+			brelse(bh);
+			kfree(tmpde);
+			return -EIO;
+		}
+
 		block_saved = block;
 		offset_saved = offset;
 		offset += de_len;
-- 
2.55.0

