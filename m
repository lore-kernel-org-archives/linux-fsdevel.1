Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.193
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792510198;
	b=4L2jnyQOqKp8GewfDQVIxJPtugsg85GpBhOxE5Gjnf6/IaJZBslRW4jFu7teIt/ab9q4
	 52vlH2zvYZFMcdtHXlgfalEgB4sImdsds2no0m3ZNJAUZFTJN4cm+Bp9QDU5n/aflKaju
	 NfvzwvBE+ZZS3ChAs1KH3yAOj/khUiML/vw3l5hMgR5jDMSYPymBW2VbIB+cFeBc+QPm3
	 rVExag9GIz9+uUJTbXPTGFsKZeajf29rhAY7/p0on0eGD637YhvJG3fhoqB6N95CuPnUA
	 T0l1LVWgDFyzZbXd8kHQF8w94hRPu5AEBbKIFPMU0khDSbjZ864K1P3OA/x34+cH/og==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792510198;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=AwtZbG8vO3DXJZ+wf2n/OXaUiA7ZcF9VhqYp22ae1mQ=;
	b=cwgUKgPueHhNM9I2kQYIscE4xaCJd/XQf2D2ap6rXh9a7c1/LGtnrzu6uz6sx7Np6p9t
	 9cn5FOJLHs7IoTVWmr4z6EpvY3RDWqtq/kt3dC/kqwHMzWfycKH+EpZKNncNMe5qcX7OE
	 xWUhoiPdvLYoAr2YdLlh81eZLNoNaMRVD5V0Hwe9bWiU8S70f8prxSh15cieGjfJZVGcv
	 STp9FM2s1HcnB4uH2gZeAfK38Fi20Wa6fWKpulLeNFBvLBIPFNgX6HGFCNMvG66w8m5/A
	 SK1amIEckGyCf5vEzarGrEaQiDefbU3+o4u69jPvcgpM/uSEsfaABEqmHdDjx6Votrw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=m6K3KvvQ;
	arc=none smtp.remote-ip=74.125.82.193
Received: from mail-dy1-f193.google.com (mail-dy1-f193.google.com [74.125.82.193])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1843B606A324
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 Oct 2026 15:29:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1843B606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=m6K3KvvQ
Received: by mail-dy1-f193.google.com with SMTP id 5a478bee46e88-35d0be18c71so934054eec.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Oct 2026 08:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792510196; x=1793114996; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=AwtZbG8vO3DXJZ+wf2n/OXaUiA7ZcF9VhqYp22ae1mQ=;
        b=m6K3KvvQnAHr5qGckwyENo1Pp7eO8y5rm8I+fX+CWw2v2Kuk9n8Hz93VUmfMln9EOp
         2nDtQkuBLTk2/MgsBteLOEc8jlcL/ZllHHOyqk5kpP2VVBNNWFEyv6C1iB326GI33jRC
         AXqKNhLi+/S21j5nGBUqbDZEJ0ri1nZ52pwfhJ4UOU+i+ToxutPJcoeKwGs3dj6KaaNf
         m55OvAzWqPI0jbbvfEUkSxKR9j4bvx9FAIVVaqLBSCvN1X8BcUR77gx1tb3aWMVZ+ovj
         QfZVs//QJIkQJzWpd+HSG3t0DeojSkr45y/0gwkv9w7Sri5VC5eL4TjecIHYFpkb9KrV
         bMDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792510196; x=1793114996;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AwtZbG8vO3DXJZ+wf2n/OXaUiA7ZcF9VhqYp22ae1mQ=;
        b=gW7f9ojXGI3I9CN58iVfOwawq6XA0MOKgKqKAYhu6PILnl0aL90qVfjnJ+92305SRe
         zcS0V0487wxn2V6LRE8dSg++96fkkAuuLH5CYfRTZwKODdOmJzL/ucyWE0fr0TyErqov
         N35y/tRMUqDn6NbpA8AXLGJwBLii+2EOxoWkJvbe+VuWxbF06hsl9yUPP6sbeT4uyktD
         gATvBwlNEF6ZyL1WVtkEvCrznu6qkkAqv7hY20ru94sp9SZK7As9ieNlIJxg5heCvfzC
         t7nmdabwgUqrJPKrvhat1NWgHbP07Ctr0fJKdF8ZlMEH11lqzdJyeYKJeMSH6mjZamas
         5BJg==
X-Forwarded-Encrypted: i=1; AKwUvBw9/DwBLF7AgaBLQhtuNyTGIDl9wywjIXGsHmTAgaSKg9CxGJvsVNgM5L7qGBg+5QTEQ0k+dIduinV5UCrP@vger.kernel.org
X-Gm-Message-State: AFq9FYLpErKebHVDD2e4UYjpulJWOw7nxUYc4OvX+6vjWa4MLy66yFTF
	2VXm656Xa6nqZ4QkFBhJ12b8mKVE1rgvkyBB1F3rum4bWs+yIU0uXKTX
X-Gm-Gg: AYBFou1/ghKxW8Etwuu8mpHyrSMQTkbQ10Us06i7NdplEHHesfriuO5jXAEKQ+Gkp0C
	8stDVf1gPYftY0a7ILLyMkKjAzwEO3dyYLntPFnrHYoGMEhX/xyrPXRx2+eaH+QCcaMZlho3cqw
	mLvLlvd+4kUcU6C3oQ0PnUHTajOlsNXviRkFNNh9vqH2CdybOXlUTk7Hq45Nbb8dCWPZCIHK+VQ
	Gqfw7sJ5B7WqAA5sei3U0b+ANi5khUARuz05hMFUXXK8MEQ79oaDSLvu47y6goQB0PkV4GPv5Fk
	nsiIqhvu+PmR/I86enGj0aAKHsIADg+5t+KBlQMVKyaZOsiPXQpCepQ9q5FSy2NcGjYofo//N0P
	yG2YYdkkGuNlmrCO3uxlosYz5mWg1EdZbqEff87soJkmyriny6vHuUebzuLwHRcMEThWajGM0lX
	YzSH9FHViHehD5io91o1rdtpse9bZz9PiX18KxO3/52vVXn2mbZWXoUHdRw9+AnAI5b37/LHKgO
	fOhe+omHsWRzcwJnSpLA0YmFQ==
X-Received: by 2002:a05:701b:4210:20b0:159:f192:5290 with SMTP id a92af1059eb24-18dbf218391mr3033361c88.13.1792510195920;
        Tue, 20 Oct 2026 08:29:55 -0700 (PDT)
Received: from localhost.localdomain ([98.148.34.5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1831a6f5a13sm44074019c88.12.2026.10.20.08.29.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 08:29:55 -0700 (PDT)
From: Hungyu Lin <dennylin0707@gmail.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	Joel Granados <joel.granados@kernel.org>,
	Luca Vizzarro <Luca.Vizzarro@arm.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hungyu Lin <dennylin0707@gmail.com>
Subject: [PATCH] pipe: reject oversized pipe-max-size sysctl writes
Date: Tue, 20 Oct 2026 15:28:57 +0000
Message-ID: <20261020152857.48989-1-dennylin0707@gmail.com>
X-Mailer: git-send-email 2.43.0
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

On 64-bit kernels, the unsigned long sysctl input is truncated before
round_pipe_size() checks it as an unsigned int. Writing 4294967296 to
pipe-max-size therefore succeeds and stores PAGE_SIZE.

Reject values above UINT_MAX before narrowing them, so the sysctl
handler returns EINVAL without changing the stored limit.

Fixes: 515c5046650d ("pipe: Pass argument of pipe_fcntl as int")
Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
---
 fs/pipe.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/pipe.c b/fs/pipe.c
index 4fa69192e6fb..5472a687ddbb 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -1566,6 +1566,9 @@ static struct file_system_type pipe_fs_type = {
 
 static ulong round_pipe_size_ul(ulong size)
 {
+	if (size > UINT_MAX)
+		return 0;
+
 	return round_pipe_size(size);
 }
 

base-commit: f47d223627f80cb7a1eb14c585fe6cb35de5e984
-- 
2.43.0

