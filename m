Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793283158;
	b=eqIFL4grm2pfGszypqS0GWGDM3Ewf+7/e8QqS7I5gwYWkdnLNP4s55CNV6tPBgEWFBdp
	 7YtgeqvzvdoNSuOqFEe2WWCTBfncRJ2DEc+F9kd4xZlm7HFyQmzX4dmbYE5iMpnzflafA
	 9RoaG1CSWuEp+M7JSEfKX3sUxX17hYpx5jSeqZKhRuCyJqqxIHuFpJJxpKEmeVr0ENgcP
	 PUX5nX8/xAyk3pVknN/l5dGYApR9Lkhfw+GpY44Z4yihpuzlj1KjNfL1wdfnREFMilSt3
	 9r0xCYOWA+MvR7KiiJBzhpYyxRDV9cJHFnNNSgVmkRc1O0fwYEZVhNdFHVWcvdOsBig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793283158;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=7A/hGTgPYtJhS8Ny/Fs+sia52LCj5jd5ywQ/PUXMFFs=;
	b=REPIDHlMiStEuFurhv9AEu3cIodWuaJ6q2p/Z+lcfdVyvvVqo49XafyIaKMD6aVN2Ugm
	 e3hLJVeAd2htHnyMdDy3UhJO9cWsSolE0FmeQDQoExlgPmWaeUNVAsddxfdrWywAU/ZDW
	 WlphlcM2TTGhc3cW931/UVyr+eGza1TeZ6is9hebQCMMvbie0jA/Gyxzfbe311Vrv6HgL
	 2VTegXeV+bK9gusGaWdpaMk9xdCy5z3SoMmtfQZ2QCMPwJrIDqqGqGmQ85jfsoBblWMDi
	 l0uUYuf9z814BRN3Yc/mJat77JzsW6L9PcpbnCswFVDW6hRU2kRccV5dSXmW7f56+2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Xe7+SWT5;
	arc=none smtp.remote-ip=74.125.82.181
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95BAD606A31D
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Oct 2026 14:12:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 95BAD606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Xe7+SWT5
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-36a2551d7b5so1022216eec.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Oct 2026 07:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793283157; x=1793887957; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7A/hGTgPYtJhS8Ny/Fs+sia52LCj5jd5ywQ/PUXMFFs=;
        b=Xe7+SWT5tfrlKsRrCvZzEKfxhCIwpN/yTj1CGCcO3Dhgh0MLSw9vfHqCmNTTqO+Iux
         75J+xPdizO50EtT5cuoIddBw3horBV6ZC5ThhibSmGyHraUhvjlAl2lyQBJBQsLF/0Up
         jYu/DDGy0gwGXdkvIkRXB+lt8vzmIDpUvBDn8nP2AQRAwGs0tOIgxcXwANMnC2bBqGZO
         ctp/ckACdoxkKAnIQuUL9AZ6Z+Pzx4QyWvHns+K6INNrm+d0LqhP51W5YaOS8EOc2PSF
         I2IGqs61eyhdM6RCTiMyiAZ1FAsRHU1MmWNuZkf1uZ6DnC+dYKbctZRuKw8+PYQqV9Iv
         wErQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793283157; x=1793887957;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7A/hGTgPYtJhS8Ny/Fs+sia52LCj5jd5ywQ/PUXMFFs=;
        b=vUOpEVZ9kJaHw17GpxQzQvtP3HWGDoRwHFK5jXYjYkrjSH6fM0h7kVGW6vYwXdspx1
         gnzWk4GZko00LFvuOSvEaXaZF3LWcmVInP0gfNJgNrnZrtbHRuDjF+yhxhyuJ3+ZUnDF
         KfO6DIuV1ITlJyfHqUbePuPIHNpwiGK4sHD9nefPfoBxKtWj49ADI6SSkp6RbytLCJKR
         JOR7SYuHDiCqOTkjaVeyq9YMlKG3vTL8/rZ74iYP+Q0rIzne8pDFfOmQwvM3fCso1084
         3W4OQU/xDrqBbiUuU/krIWGXPvhK81rArWsy/qY9XPYwrsmyw+MEmIVWMs67CXH+EXMH
         3iUA==
X-Forwarded-Encrypted: i=1; AKwUvBxnsN4D0iXeycNBG9xqpEhDv5VY8AMKDBxSzz0dnYZDmJHFgkhPhWKU3JbSDirPKXREItlBjOkdthHTb0VS@vger.kernel.org
X-Gm-Message-State: AFq9FYIcIybGZQQoo+Z31YA1PdfFDQtDmP3NoNdITIrSARfqBPqxIHVC
	CqRggwVVrvM4o2FBL7IB3jzUd7KX6NgkeJjws1VCeHeCPSx4U08dfRLN
X-Gm-Gg: AYBFou14z956XDiByHO0Ngx3Dcp3PogzbiB91251kuTNUm7ohYrY5R0YS93/0qRSzc0
	NLB+gjawYHU91oEFv+WBWPWJyVlubpxFxDCYs5i9iogEgyFo7fDnsrQUkcsT75cX8Bgw1FnUdTp
	+WVVzxXHc1E/IhZeRDgsvN3BqXvyZ+QHoSsNculA+uT3VSsx000l3ew6gtXH+5N2GzNETeTPecg
	v6J3AFB3bg+6uPoyFlLdRXlIS9TuvhG9RZkHLeu9NeQ4lo1abYTXGZ5Eb36fMHk5oJNWRtDm3se
	f+c/OwxUDp/J4X1yVskiPtrSDLjzhMVtpDHaVNo/DO+tUZB60j6jSVlStc1V7SV/OcSylz/rv8Q
	AJVeXXnZER9lc8sqW8BatQEp4Oe8qZFYjbeEvE1EAKacj13EdrFtt/N/azBPu1F1asgPjOwe/fv
	N5u7bh6zEbAfYseSnwC9tWgj7TadOwfO32ZagOyafAsOW/x8dKp7Yp8+5liNe552+NARXnvpemu
	tKkBlK/FErMXR9Vz7mu4tLChN0V7J9l8SNGDcJmgTFcptVecd9Zx8y/sH/+v0WcfLy0gcZkcD7Y
	RajcsID1rgsky3iBGHsQbDDqLELSOpsWnbdQdV/YUPZmAqg8NRxndw==
X-Received: by 2002:a05:701b:424e:20b0:194:e9e5:11b0 with SMTP id a92af1059eb24-1a9496c2e85mr3835499c88.14.1793283155089;
        Thu, 29 Oct 2026 07:12:35 -0700 (PDT)
Received: from [127.0.1.1] (67.216.200.102.16clouds.com. [67.216.200.102])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1a75d76814bsm15197319c88.10.2026.10.29.07.12.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 07:12:34 -0700 (PDT)
From: Cheng Yongkang <teel4res@gmail.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] fs/splice: clamp an over-reported write_iter result
Date: Thu, 29 Oct 2026 07:12:20 -0700
Message-ID: <179328314072.648427.13388575162083843840@gmail.com>
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
Content-Transfer-Encoding: 8bit

iter_file_splice_write() builds a bvec iterator of at most
sd.total_len - left bytes and passes it to ->write_iter().  It then
subtracts the returned length from sd.total_len and walks the pipe
buffers by that length.  A ->write_iter() implementation that reports
more bytes than the iterator held makes sd.total_len underflow and the
dismissal loop advance pipe->tail past pipe->head, releasing a zeroed
pipe buffer:

  Splice Exceeded! ret=7 tot=1 left=0
  Oops: general protection fault
  RIP: 0010:iter_file_splice_write+0xb6f/0x1170

Commit a3de58b12ce0 ("netfs: Fix unbuffered write error handling")
added the warning for this condition but only reports it.  Clamp the
return value to the size of the iterator that was actually handed to
->write_iter(), so the pipe accounting stays consistent even when a
producer violates the iterator contract.

Fixes: 8d0207652cbe ("->splice_write() via ->write_iter()")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Cheng Yongkang <teel4res@gmail.com>
---
 fs/splice.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/fs/splice.c b/fs/splice.c
index bc243ab..3ac1d4d 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -737,9 +737,12 @@ iter_file_splice_write(struct pipe_inode_info *pipe, struct file *out,
 		sd.pos = kiocb.ki_pos;
 		if (ret <= 0)
 			break;
-		WARN_ONCE(ret > sd.total_len - left,
-			  "Splice Exceeded! ret=%zd tot=%zu left=%zu\n",
-			  ret, sd.total_len, left);
+		if (unlikely(ret > sd.total_len - left)) {
+			WARN_ONCE(1,
+				  "Splice Exceeded! ret=%zd tot=%zu left=%zu\n",
+				  ret, sd.total_len, left);
+			ret = sd.total_len - left;
+		}
 
 		sd.num_spliced += ret;
 		sd.total_len -= ret;
-- 
2.34.1

