Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793632030;
	b=nhlEyL1EK6I5+W2jN5cqEHiT6DTZ3HnEsm80d8L2iXCV3P4MjzhAGHokZthuHLCAW0jZ
	 4cNaX+hPZdtUazVsCL25OohRubTw9N+1FWuLTzO3ZvGDTtXkfTzIngqNrNClkdlVQMA30
	 yC3K4oGJecGQhT3AVmnu7YHV6UPyt2q+N8mDA9nw6jCW3Xxdt3MDwjBJmma4FhuipYBBa
	 ItNRC9ZvBm5IbEAQkprFbDBcIJgfwps/E69EUl4EhPPycYx8VCyM9KoYd9831O+jA8Uu/
	 kHHMRK30HJ4Ea6t/jqqyrY02C4++phydAjqmgxrywO1hzt9HBrYJP48Ebvu2eFi59xw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793632030;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=halThLpFR9MA/xSJWhg2nbRX5BJT0ocg9O7I/oZTep8=;
	b=os0Pyzyr8eq5WeIt8McBgkbeh89PTOrcP9PpfCAQsRx21nBq366U0RDckZ8Of0O7u5s7
	 tnczt3EIV5FPgafGHPeRn0aU2+VEB/Ads57FYAvqmcW5RErQ8o38QYN0P1xn2EUa6udOM
	 MJ8UhgS30jLv3Zda9ysOw/QhzBCsyLTgk68KbUwtqf89rCZI2h0tN7tx/HiR/1Z2OSCph
	 WTrSLDaZTDgUnens/5p97NibppJk2v5+OWUD+3FiVvGxhRQvkIaqGXirdFVwKDmp8uhPp
	 wmkL/aEKtf+ACSrwYsIguXE0qn80cULNzTYsE/D33MpscOFAj8wGcwesScvjmoIVARA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YLxbPHVa;
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 038C1608A342
	for <linux-fsdevel@vger.kernel.org>; Mon,  2 Nov 2026 15:07:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 038C1608A342
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YLxbPHVa
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4a35a60499eso31001365e9.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Nov 2026 07:07:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793632028; x=1794236828; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=halThLpFR9MA/xSJWhg2nbRX5BJT0ocg9O7I/oZTep8=;
        b=YLxbPHVa5cOZpsGQyxC0GLuZjjMWkOCxx6h3WvnFgwj4gBVyLxZy5IA1n5ICpcucBl
         rN3i7ER33XzYmzC5v8SeQrvP/BvKSTSvXM8PeCfNmX3RzziIOZcQF+3k4NbX2I++BUya
         eaG5FlrldV01wdEfdtXMOHzfmhZ13T3wIpCT9+aEAQOxMdgKpt9pJ4d8VesuG/UH6tSt
         5bjjSAQBvcMK70FM8wXFv59tARo8qmj2tjTBP/9fgN/G68c+ONeOoOVEHHAxKIKLe6NH
         GNFEvjMWXcmjWU58twTKOtoqK1X66eBUJweHSNBmYXxPMdJN1IYviiAhkMOb4K0hvasb
         PPrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793632028; x=1794236828;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=halThLpFR9MA/xSJWhg2nbRX5BJT0ocg9O7I/oZTep8=;
        b=Z6ryx02ugqRW6uEN8KNSZKIYg8EBSVV1/XV1rh9YgQ7w1XVdO5d55VWsT7GBKrAWwL
         elEr43XSwCrKXtsI/ra2VExPBDLcEjRORWMFhBSyFM8E5qM5zqW5WinX0cHR/tIBIi6u
         CV1lCuc4uobgzj0KPzCvpBMc6YlOcnvLXASEzNm/0VSXr5Rgu19298FidjsvSiqugL3V
         bcqYYK6Gk4EVRemG+EJwlHhx17Nxmsjg5ywVQaPv8YBUDIamOch9Q59QbbfNZXC657Gq
         8/otG7b0ppGAROrxZOS6roT6WWAYmhuFMXGSVS3Z0iVRCutYhP2BWQIszKtEATMxmJAu
         ohSg==
X-Forwarded-Encrypted: i=1; AKwUvBw7clcZgSHMw8p1VhE2JIAoKKgFnddhzxXinS8ZssvoQfWSIqXsAZ456qToY7jP5Os13xgmkD8Bf8FYBP4a@vger.kernel.org
X-Gm-Message-State: AFq9FYJY/1FOCBUliB2nlQAsGrPwpC16AF5evXNQUo4XrKihJ/kqtf3I
	8vvKIjMjYZGA5b0Rb3Vv3/HhNEXf6AzfiIO8Ya24VQF2BL0Uaa9L9Im+
X-Gm-Gg: AYBFou3vQg9lJjlsWIdpLdtkhwoABm6/PWiEY6y5zlXbEIocjhIq7DcL6ggTeUJt9ob
	jLaENgEfzpRn5mtnaFcLApmPv3ekFvhomc8F4a++GL5RnH8TeMLLsrTkeaDIm31qD0wCYd2iefC
	vBwcKP7LWkaKb1h4c4nSnq0anhvext4GLnzd1MuMRmVymRcqSdF+9xqYtW+1Xn5r25NE1GeN1Yq
	L0GYvpX8Yc1Fc8+jbiboty3XFai6g1hORADvR8ozDdTX/DdiOq5t4agLlJZpcShDTEUVeLk8HtO
	QgEHrbyhkf0H98YDsmbv0B4ftrlyE3dv1cV+e33oPRwcqP/mmwe03Hi1RQJ95zo4Z0G0HSPzyfP
	Y4Kp9lheLQPpZAap+gefhdn+J0AeZunUU3asUEK7aVDdd3+WDGIsE2jivNGtqlAki0+3/K8nof8
	35zHv7VgU9Esve3btjvu1kPm3QuLemObRIao1Ni648CQjQ3pJaoMnmPXL44d30AbF6XAXA13WrZ
	tKIoMgb858lE2ejTwlQbp2uNTCmx1vXS7sjcz/nXqhJHqlesLYY9cdhbxcvmKCBbSFXvsI4jOU3
	wooSmF88faoHu3mpeYZ3aoxTMsIpGme0jfEyNv3xr57+
X-Received: by 2002:a05:600c:8b55:b0:4a2:1655:87e2 with SMTP id 5b1f17b1804b1-4ac17b2b023mr254051745e9.19.1793632028227;
        Mon, 02 Nov 2026 07:07:08 -0800 (PST)
Received: from localhost.localdomain ([2800:810:84a:dc6d:d32b:1515:b2a9:c74e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4aa81b7fe80sm395629535e9.11.2026.11.02.07.07.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 07:07:07 -0800 (PST)
From: =?UTF-8?q?Iv=C3=A1n=20Ezequiel=20Rodriguez?= <ivanrwcm25@gmail.com>
To: David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>,
	netfs@lists.linux.dev
Cc: Shyam Prasad N <sprasad@microsoft.com>,
	Steve French <stfrench@microsoft.com>,
	linux-fsdevel@vger.kernel.org,
	linux-cifs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH netfs v2 1/2] netfs: preserve prepare_write errno on reissue
Date: Mon,  2 Nov 2026 12:06:54 -0300
Message-ID: <20261102150656.207612-2-ivanrwcm25@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261102150656.207612-1-ivanrwcm25@gmail.com>
References: <20261028181229.1408342-1-ivanrwcm25@gmail.com>
 <20261102150656.207612-1-ivanrwcm25@gmail.com>
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

