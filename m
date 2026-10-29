Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793283163;
	b=ufBEZXBafCpa+Z3IBEaPYZ8dIzww6PC8qNHcufZy1e0qhQH4PJ/IrebmzzFd3VSYzUgk
	 iWWHeyEJJjNL439lWEfMhAiRvkR43Sn7UMGtKo9K+KNDmo8HeAuqupkr8TK+l5hehpV97
	 xqk5uyIAK0zlDOeA9jdGux2em7WInHA8SDXgA0j2VjP06uLe/xtFxByUbcTcxYemlfIoX
	 6XJrG3QLYc9av5xiqsfCH5fQmEW5snShvXV58yamo3FPh9RSDJexMAvX5c+RFBXTsjdqQ
	 me6SPw9LnvnUrV+yxiLVxxjb7c3MCi+h4zd7GKpcnDpGND48bKA/eIGAj8jzkmMg23Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793283163;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=ugO9Kth5t8s7Fphk46Xo5ddbEmG6KSdUT5+AGSNMycY=;
	b=CkBFpSQKfJF0fIKIKK/G/qYMaTzeS+SynMDu/RHlO9xNFS9OfFBEwN6EyM89sGBiHycR
	 YuCtZtaLy/779GfqqQB2S7Mv3CCbs5hGRMcu6UlQnkfSXclw/frMpLXZ5RGlsRL3Q25Iw
	 bZXZF6Fq7YlHHjVWelS4CqqH85r4aqvISgMVGYIjBGgT0FP+9wcptX2NDEDbA+3UbqoHH
	 lQ200mFtZVthpgy6Mt8F7jWu0WOr0djnSmLregWCgztcIJLLDwI/Es7xiGfE/guOwTMof
	 OONDAqkv9ouC1Ff0PGqNYPD0CP0G1VVj18bvR9fHCQzqotCCq5w4A8T6LXW4ebNk+Gg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rsYPJ+dW;
	arc=none smtp.remote-ip=74.125.82.54
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 971DE606A31E
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Oct 2026 14:12:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 971DE606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rsYPJ+dW
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-156cbe59622so2246326c88.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Oct 2026 07:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793283162; x=1793887962; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ugO9Kth5t8s7Fphk46Xo5ddbEmG6KSdUT5+AGSNMycY=;
        b=rsYPJ+dWvfE9hULcrCx5P5nwSB1FWDWlVyEX1LPDC+Pcz261VAvGW5vYXrq7H2aMas
         tnD7MrDMYnhV1k5ZZeMypHaX1rdsHJawevsLKNVqMcs7YX4qfws02uTLpW0PzxbcLiot
         zV7Xjb+sL/iAbC6apTnitAw4Ktli9Nh4IXO9Xl5p2qOt0WD70/iTqEbQapr2coXoi/bO
         wBu3fsneuUGOnzP+X61b7nOSojH5GclQbq5nsW+KNIaKnSpRj7QnCzVWReqIbsb21PeI
         xs84S4BYfBgc1g5nf0iRf3/oJ/+94rIjnl5CGMD1CUEx4jriiybwMID5kUi3iYad5b+b
         Zokw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793283162; x=1793887962;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ugO9Kth5t8s7Fphk46Xo5ddbEmG6KSdUT5+AGSNMycY=;
        b=dUdpCgVyXmUKc+3JWR3B5DK6oUAgW4dexSlEe6Ch3x5FhlqJJFjXBwkFHM8v+4Q26U
         234z5ni1nEW50WKrZUUlARBtANyhaGXI3qZ6DdxymmINRMxALrIeM28p9yJ06vC+WYWk
         X93kJfGuixSBi1bFqo38WQpL5HIW5VyHdaocH89zwU0n8SD5pN0LhbuU6urSvSVl39Qe
         0uEcZ/+6Z8YFz0dE8OXG2XajRLnwAlse4r/sOcvZp6+aPsxZEVt8Cki8qW9Kz6LRzQYN
         wBVZtrrWjHuqVzqc7MaZ3K+5xXn7PESv5DGS8mQnXZC2OSsBzAtl5quSd+xhiVPUfNu8
         uvYQ==
X-Forwarded-Encrypted: i=1; AKwUvBwHZS3kcIby3Bd9CsI0KQe6sBP6URLhXLnhqDz/7lG7mzZq/dTCYzdodV7TL9eRBzy5nevyhT9YFCJY61pe@vger.kernel.org
X-Gm-Message-State: AFq9FYL38idrI0y5tZ+mjneFFS9skL1bYMv8SzV2IRdntJAW0d49KMce
	wkwy79ihzwy3zCOXI9H23CjDeZctvIE8UrdIajgKlJ2OT9oaZQW1hxL6
X-Gm-Gg: AYBFou3LV7sT6dgLzJ+hMYXGSWZuNDMShDUr/yesGW3XQqqNpg0/aKL88m+Uzce30vf
	CMAGL5lUYVrMvSq8zWWOCpcEQZ7gO63MBHjznQKtVeBF7oWQ1cDG7iiueqYMCSuxyXf4DhucH9A
	PC9g0Yp6lnNx1ryK1KpY5LrmpSWiXG6iwjriGRkV6MPI8U2+5ex1u+Zq6rzxcHpx5bMn0i507cv
	w58YGsE2X+6Wk7aFX5dD3tOJEK9u0ChVbEXt8r9zuf2cpfwu9jZp/TnWRnYAQmODkNU/jRJ9snF
	lY/+CubP5R928O070efI+s79YWn7bWd/a7/csG8XsCmMBUFaCYWj65lGOndAM6OL9hxqvte7ZON
	WDbrd/tnTusuGIYRIDLZZiymb94K+Lfj3av/8bxGc744Ac3a7Zj3o3Uu+YvmMQjpdfIG638Ptqu
	f7jbBFAjKY5g6SPhzdYSQsJt4ay18wiropIPzniU2nx6psnhmdpu558tZgacCFuAdxfcC3//LsJ
	2zJqmSAzFyQ/jp/isBu6ZUOEoN1nJPSKgif688gB3SwxTZVgp1662zVYOA86+i5HVZrrx/V+w/e
	eHmyOvWCtRPb+CiGBeY6yKVWsQDNSbc76FufoLeY+BR/fuwfJoA1bA==
X-Received: by 2002:a05:701b:4203:10b0:143:3c9f:10a6 with SMTP id a92af1059eb24-1a6c9af1e26mr7955968c88.4.1793283161611;
        Thu, 29 Oct 2026 07:12:41 -0700 (PDT)
Received: from [127.0.1.1] (67.216.200.102.16clouds.com. [67.216.200.102])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1a75d76814bsm15197319c88.10.2026.10.29.07.12.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 07:12:40 -0700 (PDT)
From: Cheng Yongkang <teel4res@gmail.com>
To: Kees Cook <kees@kernel.org>, Joel Granados <joel.granados@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject:
 [PATCH] fs/proc: fix the write length returned by proc_sys_call_handler()
Date: Thu, 29 Oct 2026 07:12:20 -0700
Message-ID: <179328314073.648427.7892850166511253762@gmail.com>
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

proc_sys_call_handler() reads the write length from iov_iter_count() and
copies that many bytes from the iterator into kbuf.  A cgroup/sysctl BPF
program can replace the new value through bpf_sysctl_set_new_value() and
update count to the length of the replacement value.  The handler then
returns that adjusted count as the number of bytes written, even though
the iterator originally held a different number of bytes.

If the replacement value is longer than the original input, ->write_iter()
reports more bytes than the iterator held.  splice(2) passes that value to
iter_file_splice_write(), which subtracts it from the pipe length and
walks past the pipe head:

  Splice Exceeded! ret=7 tot=1 left=0
  Oops: general protection fault
  RIP: 0010:iter_file_splice_write+0xb6f/0x1170

The write path consumes at most the original iterator length in
copy_from_iter_full() before the BPF hook runs.  Return the smaller of the
adjusted and original counts on the write path, so an expanded BPF value
cannot exceed the iterator while a handler that reports a shorter parsed
length still produces a short write.  The read path keeps using the
adjusted count for copy_to_iter().

Fixes: 4e63acdff864 ("bpf: Introduce bpf_sysctl_{get,set}_new_value helpers")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Cheng Yongkang <teel4res@gmail.com>
---
 fs/proc/proc_sysctl.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index 6c0859c..eeebf81 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -557,6 +557,8 @@ static ssize_t proc_sys_call_handler(struct kiocb *iocb, struct iov_iter *iter,
 	struct ctl_table_header *head = grab_header(inode);
 	const struct ctl_table *table = PROC_I(inode)->sysctl_entry;
 	size_t count = iov_iter_count(iter);
+	/* ->write_iter() must never report more than the iterator held */
+	size_t orig_count = count;
 	char *kbuf;
 	ssize_t error;
 
@@ -607,7 +609,8 @@ static ssize_t proc_sys_call_handler(struct kiocb *iocb, struct iov_iter *iter,
 			goto out_free_buf;
 	}
 
-	error = count;
+	/* the write path consumed at most the original iterator length */
+	error = write ? min(count, orig_count) : count;
 out_free_buf:
 	kvfree(kbuf);
 out:
-- 
2.34.1

