Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793211160;
	b=5ERjTLHv7rfBrbbZgfZzvdHvvDNiO4Nq4oAB3TKIovh2AOEpqoRQqtCnzlmG5SCTseeK
	 Ge6ANFdxsxVk0FodJVsmqaxuqdU8A6z4bxsid4DVJqhAZ6RsBiTy9O/FPCnN4/3O4T9NJ
	 bzDaaNwmzlrbXjkB8CIcV3l9eCKZ7Z8ZjGyYjeA6yL6W0oKRqhQxzPs6hx8m9P5p7PHAo
	 M3p8Fx40gQDEv/WIDkksXsw5G2byhlUHCGgmTZRi24gi8Y25Kl1zmMA7iZ5K2d0wG0/es
	 rFgDvvILlAgZEAC3nLkyZPL+C50zvehR2afeMuveRYuDTvidQFUZ3EDP8u9u9p5ScpQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793211160;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=halThLpFR9MA/xSJWhg2nbRX5BJT0ocg9O7I/oZTep8=;
	b=N2mPt5zT9ajLGO18xKoYwUb9zEFv54wlooC6b75cthuSSLH0zilGYrn4DrbvU/+N+V75
	 6CMgDgF1zlYekf6p0tnBxiTsQnj/yVr1Etz+1jXJ4JI76f0Dvcc/yFbxax95pOHbQ+/5c
	 FvUrZubrqFOOaHaphiGYn8S74SAcucJb5GvYmAOIFX03H1hIF+qchOmxdhVGFzVWyzlCq
	 ALiA0br2UqGfhwgWLrMWxfrVREUAYaE6KMydTUDpb2/4MCjaIKLk+euIQArhfOoKEr/Oe
	 Ns9VpUU2RNBxcHt/R9lnpvxKvs1+OO/TZ7A3Vco+JnX7kwjsZfDXxuRRtWAmtxbsVew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cjZzAV+O;
	arc=none smtp.remote-ip=74.125.82.173
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A191260A3806
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Oct 2026 18:12:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A191260A3806
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cjZzAV+O
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-3514b90bb89so2459130eec.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Oct 2026 11:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793211159; x=1793815959; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=halThLpFR9MA/xSJWhg2nbRX5BJT0ocg9O7I/oZTep8=;
        b=cjZzAV+O0Vwxp04eP7Q+6VVIoWd328QqSN8vm0N+SXrH7QFIDfkdAwNHn06soKWe86
         f/KBcsaIL0wobkehF1Sg31pBXx3YL75y5MN8BcIL3xeJCp4IMV0ruirfbGVtHtfN4Jdo
         THDFokqyCIpZZQDTpeQBVtEs5H9Ifgfh5+cNdW2O65MV0AVHxKFDaPFBrmttLEnE4Wvx
         TU5y3MCosHXqGr81EhroYVxVW7MQNqZTvgB9Pzd17FThOpm1MHRjRTMA2ZCniESTabkP
         FjhRhEbPgpZ4STMCPG8gxT8SvqlPeVMM4o5zm9SXR19t97+PswsyCrTBUmV6rSIAh/ZK
         1N4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793211159; x=1793815959;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=halThLpFR9MA/xSJWhg2nbRX5BJT0ocg9O7I/oZTep8=;
        b=BMNtsgsGYUj9AWf8iqB4RuDU+uY2JIwINroNiZ55/MZC8PjCctJiwNiOhKczsmTPO5
         Sz7ocoStuVxvSvYQbxx+KOw518wvtKflBZKUBGFjgfjkkTtPp+8cq9F1k/bXkxwe2+QX
         Y/mWEq/yvr3JjH80O36+e9w1YMi45iSMNFFiPOUM7QsOTYrQpLX8lByvM8poyMIccN6H
         cdzgOaJH6EGaVVszNpOoB4E2xp7Hi9n+q6Wm1r/SgO6tRpfMucfmtJ+l0NqTZ7lBHOoV
         8HpMDcvVcp4FoGUFVoiB1GX3exXjsy5I8fxMdV9nDr7znvG4OnVmqMzhMl/YjQHh+eci
         FQeA==
X-Forwarded-Encrypted: i=1; AKwUvBwBUEGfQ4BtK2U7VFhn53ZYetjFCNtNIWsyYV1CUx0NVLEwqsK0P3mjwkyTfFPoUqnA5Hz6tpA5ZOkaVb5g@vger.kernel.org
X-Gm-Message-State: AFq9FYKmjawiOyXaqPLk+7FTXpZnTuHmv0aLHQgbg4CCp3mTG807NcU1
	/hjCBjvA+n3WFn4IZ1NjgPZTfa7TBmBMRmtVwy5oUyuEFOfOodXSXKxc
X-Gm-Gg: AYBFou1G2v+L87Yin33GqCShRQ/aZhjLygwXsUwtzWnh24ShnXHUMElx/RdwmxHavJw
	Pg+3WTFNBX9DRNdRHbHAi2jUsSNmkT37Uq3bd2ddyqPqw76LvrQSo9z0rAiN3qwWE4xx82bfXQF
	3UvQevDEgyhpWbPhxptfSl5HAKHRtPFFhFYWHJ0pcisfpsom9LYQ2OppgyCX2rQRTKAcv7+P1A0
	Fr3OS9GaGKbJqOAD8yECqDvehBHFPK9DHydBHQonCiCs01/08lPP4HczRYM6+iR61cU9ZjZz0Re
	rEJt6rw02eE8fxl8TgcJnTwyA2jbd5HWCkb/C/D7PGv6ii8m84WqyU3hPbwFHzif3HkEexNhoBA
	xZ144T3k7in5+uyUTqVMGrZDOkFhjiIpx5VQ8XOdSxIJNiddumU38C4WMAgXrGl9cnaNw0JL37l
	7gs1ZPNPFTjXU3xU6wEUZTmc6uN36cJD/EPXrPwFf6y+ur1lDOtL1EPJnEp7o/Jhb64ZHooG5/P
	T1qKTgJIZ8nWlcOTHxdbASInirF8HLwWfrz3fu9/XVFcIx/NMh06LA9bewwSaft7M3+tkeyA3ha
	XEsZRe8C74aP55dNLQV/j2o=
X-Received: by 2002:a05:7300:d706:b0:35c:6ffd:e91b with SMTP id 5a478bee46e88-36a2013bd0dmr5935780eec.40.1793211158462;
        Wed, 28 Oct 2026 11:12:38 -0700 (PDT)
Received: from unix.. ([181.229.23.179])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a238da675sm8309394eec.5.2026.10.28.11.12.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 11:12:38 -0700 (PDT)
From: =?UTF-8?q?Iv=C3=A1n=20Ezequiel=20Rodriguez?= <ivanrwcm25@gmail.com>
To: David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>,
	netfs@lists.linux.dev
Cc: Shyam Prasad N <sprasad@microsoft.com>,
	Steve French <stfrench@microsoft.com>,
	linux-fsdevel@vger.kernel.org,
	linux-cifs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH netfs v1 1/2] netfs: preserve prepare_write errno on reissue
Date: Wed, 28 Oct 2026 15:12:28 -0300
Message-ID: <20261028181229.1408342-2-ivanrwcm25@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261028181229.1408342-1-ivanrwcm25@gmail.com>
References: <20261028181229.1408342-1-ivanrwcm25@gmail.com>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

prepare_write() may call netfs_prepare_write_failed() (FAILED + errno)
before write_retry calls netfs_reissue_write().  Clearing subreq->error
to 0 for a clean I/O reissue (82e8885bd763) then makes
netfs_do_issue_write() terminate with 0.  The collector copies
front->error into stream->error and mapping_set_error(), which ignores
0, so writeback failure is silent.

Skip clearing error when NETFS_SREQ_FAILED is already set;
do_issue_write() already terminates FAILED subrequests.

Fixes: 82e8885bd763 ("netfs: when subreq is marked for retry, do not check if it faced an error")
Cc: Shyam Prasad N <sprasad@microsoft.com>
Cc: Steve French <stfrench@microsoft.com>
Signed-off-by: Iván Ezequiel Rodriguez <ivanrwcm25@gmail.com>
---
 fs/netfs/write_issue.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/netfs/write_issue.c b/fs/netfs/write_issue.c
index b8237e1314d8..f23364116421 100644
--- a/fs/netfs/write_issue.c
+++ b/fs/netfs/write_issue.c
@@ -268,7 +268,9 @@ void netfs_reissue_write(struct netfs_io_stream *stream,
 	iov_iter_truncate(&subreq->io_iter, size);
 
 	subreq->retry_count++;
-	subreq->error = 0;
+	/* Keep prepare_write() errno; do_issue_write() terminates FAILED. */
+	if (!test_bit(NETFS_SREQ_FAILED, &subreq->flags))
+		subreq->error = 0;
 	__clear_bit(NETFS_SREQ_MADE_PROGRESS, &subreq->flags);
 	__set_bit(NETFS_SREQ_IN_PROGRESS, &subreq->flags);
 	netfs_stat(&netfs_n_wh_retry_write_subreq);
-- 
2.43.0

