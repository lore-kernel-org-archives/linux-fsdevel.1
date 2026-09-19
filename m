Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87CA63F44C1
	for <linux-fsdevel@vger.kernel.org>; Sat, 19 Sep 2026 12:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789820969; cv=none; b=Vu+BLTZCeIsVXqt/I1FcDHmrpnArZQuaxq9QeLmiZ2xFtZLDFkPovpLgCtg1OlDz8pLnWOrnhaGRPLsEh1qfR4It4QuLu5NjeWDrSDRz90wPGUtEepXl1MBf+GmmkACAv1m8vVprK2AysCl/iEDmP9d3pXeUOxFiifIdLapH7jQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789820969; c=relaxed/simple;
	bh=VkqkHZ0i7OLAN5olcG5gT1wp/ubbwe41Co6ZCLsTZiw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MCtaXLpdgPhyJ+LhFyKpE96Uo+bo0dd+IfFbc2hhWxEfik8WSuWPr/FibRmV1Nrq64Xx7ATfF77khNmgJBvi5Woq5ROl+VZcM6fY+0IZEGHEebc75E7WnFqi7HRo2hxF1TFJjeOQSYXRt3Z4n2bBXxDzutg8U2C83ZZM/ya4px4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bDTM4aBm; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bDTM4aBm"
Received: by mail-pj2-f43.google.com with SMTP id 98e67ed59e1d1-396ccdaea75so529008a91.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 19 Sep 2026 05:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789820967; x=1790425767; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YdeBTyrUHkUfCGERn35jJ/kL70xI07fcNh+mvdM5cJ4=;
        b=bDTM4aBmhck9mJRAO8dB8RdFoiF/Odvknq93fEMa90fCH3CKrSgSd6sz9Nx9Hmr6X7
         j/ohEX9mCPsX/28XNW1NmL1A1hXhIOSTELW20A228yppf8Gs3CVFDbk9VlOB9GoZjzh3
         Rd1PLperNcToVUxQDYBpayCK3z7HmLZgsLRgdTrvikOkmPcriLM7XtRzvQj0qjldiYQU
         zpQoL7Rj2IOy1lQn5tCgIeUxoWWh280T/N1CQk7Fj4hSRmyT4OijDQJD7qXeXi3x0OuR
         AoN31w7FZaMFP8RpIEP526yU6n1q+n85oZgqrsa4a9vU94ueHm+qmoyvATeF4I0nShdN
         1rHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789820967; x=1790425767;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YdeBTyrUHkUfCGERn35jJ/kL70xI07fcNh+mvdM5cJ4=;
        b=B+yFWHXpO5ZgXYlGhexoFdSsxh9wDmnwTQZX2VKKtI10rG4jNnMLAjudwpejf5w2DB
         C4Y288/OlsWwZAz9ak7T4l123oL7IXtXGCSwQ0D+oaWnJ4o1NTppbGGazrNtI7s74FO3
         QqoduAYlbnYgD3kn6ftlCUKF7bKWDRzk9vSR+UdcRHSYTn/PmDqb3QWfN8diXa/AuXzV
         85aY2RmTGVt782mLsGdffbzzdmSZMaOOrxgAkkGmXf0jj7xzwkZYcHrQPNmhiSfJJJVU
         KWsE88KsUOl8CR0fSLywVNgspQyzCdwnegyzAe4l7LlfzqbYy4DCKRF15G+1ibCduRfZ
         9cSg==
X-Forwarded-Encrypted: i=1; AKwUvByAk2V8FLOjLtoa/S8g5uKeXLeLAACEsryHnyOidiCCUwFiB6Go9XSxJ7xysuoLxoCW60Hs5iW8BWaZd0D0@vger.kernel.org
X-Gm-Message-State: AFuF++mxheTLACzUHphU3aEqSdPaGa8u7ztysAeovk7yJCT2kdb82JW1
	oFv/0ei4ldswb0IhkoMIR1B7F3yMBO4IQ67x65VnBwO6zg21+8S2DPEe
X-Gm-Gg: AYBFou2Sxsn/LgJkB1toi6bfq5azYuY5XasKNXu7mEQQ9yIbBzd8qxhggT61BjocS1g
	6ZksK9vrQHfXiyIIenkx65JQWj/Bz0/BmtK/Alz0VSxNdtF6cz3G+mAfyBO3dWaNvAEjRS1VLOr
	hW8BoIIiNWiEcKr+PztP74SBDYLiqz06/UdzGZu+BF17YzehlUJ9ESihuFD/NsPGFhUymHkWPiO
	+k15Zg3PTtWFymrIa7cLq5i8zV4Ev2P6DlVQPVMJJyQI2wzQG/flpFE7kfZIpm8M5An8FCBf7h6
	j0d34pDtPNQJvL+4VCr2TUfkohbkwcpgJuJXzCxg5AwzwuabDMHvkjILjpf+/p6bhnIzyESBgqv
	kFZUf3/byTzBsQEMQd95aChpQBUMan8/Ph6HQGH2W6KBj3fez6WzQ7QEtdMLetjSSmC/Gonz7mF
	J3rCsN5WM/7D/YwrtRzm/VcUSK2ZR2B1G457pml4cUt7m4SDzBPEu1xBvdiao8TwDbYzNNFK7L8
	tyyJ+Q=
X-Received: by 2002:a17:90b:3fcc:b0:39e:6c68:fd8a with SMTP id 98e67ed59e1d1-39e6c68feacmr2487104a91.31.1789820966752;
        Sat, 19 Sep 2026 05:29:26 -0700 (PDT)
Received: from RyzenBox.localdomain ([137.59.96.253])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33c331aef9bsm5978411eec.25.2026.09.19.05.29.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 05:29:26 -0700 (PDT)
From: Omkar Chandorkar <omkar0926@gmail.com>
X-Google-Original-From: Omkar Chandorkar <gotenksIN@aospa.co>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: Namjae Jeon <linkinjeon@samba.org>,
	Steve French <sfrench@samba.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Tom Talpey <tom@talpey.com>,
	linux-cifs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Omkar Chandorkar <gotenksIN@aospa.co>
Subject: [PATCH v1 3/3] ksmbd: fix FSCTL_PIPE_TRANSCEIVE file lookup and response handling
Date: Sat, 19 Sep 2026 17:59:10 +0530
Message-ID: <20260919122910.2382-4-gotenksIN@aospa.co>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260919122910.2382-1-gotenksIN@aospa.co>
References: <20260919122910.2382-1-gotenksIN@aospa.co>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Named pipe handles are tracked in sess->rpc_handle_list rather than
sess->file_table.idr. The generic IOCTL file lookup therefore returns
-ENOENT and STATUS_OBJECT_NAME_NOT_FOUND for valid Windows 11
FSCTL_PIPE_TRANSCEIVE requests.

Validate the RPC handle under rpc_lock and bypass the regular file lookup
only when the handle exists. Return STATUS_FILE_CLOSED for invalid handles.
Populate the response file IDs before dispatching the transceive request.

Assisted-by: OpenCode:gpt-6-astra
Signed-off-by: Omkar Chandorkar <gotenksIN@aospa.co>
---
 fs/smb/server/smb2pdu.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index 619ef0e11..76f98ab4f 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -9662,6 +9662,26 @@ int smb2_ioctl(struct ksmbd_work *work)
 	case FSCTL_PIPE_WAIT:
 		no_fileid_ioctl = true;
 		break;
+	case FSCTL_PIPE_TRANSCEIVE:
+		if (!test_share_config_flag(work->tcon->share_conf,
+					    KSMBD_SHARE_FLAG_PIPE)) {
+			ret = -EOPNOTSUPP;
+			goto out;
+		}
+
+		/* RPC pipe handles are not in the regular file table. */
+		if (has_file_id(id) && !pid) {
+			down_read(&work->sess->rpc_lock);
+			no_fileid_ioctl =
+				ksmbd_session_rpc_method(work->sess, id) != 0;
+			up_read(&work->sess->rpc_lock);
+		}
+		if (!no_fileid_ioctl) {
+			ret = -EBADF;
+			rsp->hdr.Status = STATUS_FILE_CLOSED;
+			goto out2;
+		}
+		break;
 	default:
 		break;
 	}
@@ -9790,6 +9810,8 @@ int smb2_ioctl(struct ksmbd_work *work)
 		break;
 	}
 	case FSCTL_PIPE_TRANSCEIVE:
+		rsp->PersistentFileId = pid;
+		rsp->VolatileFileId = id;
 		out_buf_len = min_t(u32, KSMBD_IPC_MAX_PAYLOAD, out_buf_len);
 		nbytes = fsctl_pipe_transceive(work, id, out_buf_len, req, rsp);
 		break;
-- 
2.55.0

