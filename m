Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D4AB345ED9
	for <linux-fsdevel@vger.kernel.org>; Sun, 20 Sep 2026 05:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789882301; cv=none; b=EgL9TbfSnOslSBt5Snkw8XPAOKSAZyrk2uqwyud/Ek0Q3OXCpaHgzs/bZfKrv7rlLYINHRNyN07Lha0Zv4ucQYBBxXNGI3eDgvliEDWcQjn1vpWdFeuY7OcK1PjXYSrfD992gQNHmJ+GD7ooaEgCi9Koxz7GxUcqJb+GyXzc8VA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789882301; c=relaxed/simple;
	bh=BVK/mipEVmx0aEbF3++Esf8632m9xjXxAJa0jmkYW9Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LlIl/jIqfAqx/i7gJqWWJqCu7WEuBeKfqxrNqj35dzwUuk3p/5cLi7uQemS9Dkk+1BatFSso4AJZdVqYZXlYfdiohC3vCI2aS86RQ5/mZCuGwoQQsMiD+HvZ+xOMpGrVCFbUKHqPCktY8QZuZQem+jyX6qFVYU4c1zRdsnJQMl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VhpNlCC7; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VhpNlCC7"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396cccbba92so1816381a91.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 19 Sep 2026 22:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789882299; x=1790487099; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=n6OYfPpY2n3Ub1//85aPs00ESb2T3E/tFcWtxLIp2QU=;
        b=VhpNlCC7Y/jNt3s6uvTN3zdvamO6mFb1bWFVy0VTShcqIGc6QGq44NIbR5LZujPh/f
         i5P7CiVmqDTHS/WlngewDv8vpl+lcYnL4+7Dc3UGsKS1y+wE6j0NFxQLNZVdtOUDxDXH
         wUlBIrw1dY73xXYGgq7SorzvC2FQy2ri5Sfe28GnrvgbzBTjO9vDBLT9spvbF0iMO06Z
         xz+sX65RqJyYKQ/5raAL9PUaqGw2NY02ZPWRc8RxSFFr3EqX9QTTyPspQ1xcU+iknkLZ
         S9b1m2y+0BMs7iiS8thoylzIlkII6XuEh2Af+w4N6vYXRpv0dXZo0Q6ufWtGTymPR1Cq
         YQqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789882299; x=1790487099;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=n6OYfPpY2n3Ub1//85aPs00ESb2T3E/tFcWtxLIp2QU=;
        b=dXN8mKyiG5OSMai44S0/En6EUQJqCpugzsbXPBmjMsUIpdG7oOa6Op5zZfTzlNSCwX
         SkwCOYufuy2RtGqHRRK5CvWDWcuXjGgMkYOzb/Tk3a5YN1tzqo7jTe9wX/PAgVNwRBe4
         b1x/PiPQvgI3qOAsHF2jFtet8uex8dgB/Cxbj262ZJcSm+okf+r7sg39xexI2x7zgDBY
         mA0OE89abDjjv+6lLGsG18fPcEHv5BN55Yfm5WNcAUlggFI0nBHZwAbAv5EAtZtjtdGw
         OA41Mu0gqzBxuLVjheUSGWHYF5voiIB8gPLg7aE3P4CVVeORErCYkUA2Ch9lhiEEWd3/
         jXDA==
X-Forwarded-Encrypted: i=1; AKwUvBy0dF8M1lO7Ds5PRmbCfAW3UkHl/O1jTvdURc04ws3tiG4MKqhE3lyp166l2dtRxA9Sp/xh2vUyGtt7Wxva@vger.kernel.org
X-Gm-Message-State: AFuF++kxWUdp38X+XCfLhlsYUNjriX0MOHEdv6rbNeihyFFig4TKtlfe
	O/FE4VuusiFeyotgU23CtYlOWXP2ilMPYkJOk/hWi97mkg81isomVt2h
X-Gm-Gg: AYBFou0k+4RfbpzUZvJQTh399mof9VYnDlvoR8oIYlJcVPj6z5Oc95yd/DpGZpvO9oW
	wQXqaCFxOpermYRdGYBJfo9cYsuZGRZJF39cAHV2/QCR+BVUqGrwFX2UyM+5I5Y9LF8LuI12zZv
	RpsF6b0rsrF+h55gAH9fyOxQXOaZNeL/s9m1UEP5jqxxpfFLMmI0y/lNLZDQV8LudsOaxbn2JST
	BWHyyEZLMk5FYjtI8+6VaLUK8777xLn/RWQgNFK3bOHP0+TNb7YN643wfYVmK8C6hSM/DCXzVkT
	eaa/p/IpoxFA+QdnopEzXSEdsqCMRFjQINQ+ONcCqd68BSZ1eZKTEmR50A6+tb+fqAYKLgT1ys5
	n4gZqrLI9fHStQSACgTnvVGRDqNbKKKgX5OFYKnPA4KB7kgCzx8CHJILBb0aUNjwFhEmhHjdsAt
	ukFMCK84s7jfKQi/ikkk8k0f2WHzDdb7BarA2af7qOBUvdIOool+HFPq0Ln/cDacDkX4/ixzE+j
	yq8z+E=
X-Received: by 2002:a17:90b:3c50:b0:39e:f667:68ee with SMTP id 98e67ed59e1d1-39ef66774eamr4763219a91.27.1789882299413;
        Sat, 19 Sep 2026 22:31:39 -0700 (PDT)
Received: from RyzenBox.localdomain ([137.59.96.253])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-144d55cef9bsm10438475c88.10.2026.09.19.22.31.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 22:31:39 -0700 (PDT)
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
Subject: [PATCH v2 2/2] ksmbd: fix FSCTL_PIPE_TRANSCEIVE file lookup and response handling
Date: Sun, 20 Sep 2026 11:01:26 +0530
Message-ID: <20260920053126.28654-3-gotenksIN@aospa.co>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260920053126.28654-1-gotenksIN@aospa.co>
References: <20260920053126.28654-1-gotenksIN@aospa.co>
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

Validate the RPC handle under rpc_lock and bypass the regular file
lookup only when the handle exists. Return STATUS_FILE_CLOSED for
invalid handles. Populate response file IDs before dispatching the
transceive request.

Assisted-by: OpenCode:gpt-6-astra
Signed-off-by: Omkar Chandorkar <gotenksIN@aospa.co>
---
 fs/smb/server/smb2pdu.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index 15e2801a8ce1..7accc4af44e1 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -10922,9 +10922,28 @@ int smb2_ioctl(struct ksmbd_work *work)
 	case FSCTL_QUERY_NETWORK_INTERFACE_INFO:
 	case FSCTL_VALIDATE_NEGOTIATE_INFO:
 	case FSCTL_PIPE_WAIT:
-	case FSCTL_PIPE_TRANSCEIVE:
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
@@ -11083,6 +11102,8 @@ int smb2_ioctl(struct ksmbd_work *work)
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

