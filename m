Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793626225;
	b=Kt0ubYOmBoTw0ak4X9GRU9YOJ23zXdu5znZa8gl9befeCcVRfR95nS41fvyATSb7PMfL
	 VziHjJeMfLb+OkrEPCqAbd9fOrtDpavRdpXyC+wNgRIykVYH7eh1F5JsEicxKEqfPj5ZI
	 +Eskn33PRnxG8WFKgGWNS/bmfksKRCxvOyqV9frj2mlS5wqZ1ObOISUt7TuX2jeKhASMH
	 Kmxt/s01wMRauZiEAsU7yKvwYzRJatIvZ+zqWOGiYeFwPf0CdZ+6hP6/hGpLMWz5j58Ig
	 qmarCuP7m5FJSI5QUbfp+6QmXlxCPC7dM4FTDdUniOJ7YX/4XOK7ltskPjVtzDcKWcA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793626225;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=MbpiROGQuzVONeXp96zntA9ceKse3+uC6QJ979xAbqY=;
	b=wyCD7zNaiaWeGof2UgC1SXfHsPM+3l1Jys4PR4QXTwrmL9mUMiB6aULZSVWGkLYnrUpG
	 lPIRazGtJeY6x8xJWJfdDVHklrMmuujUsQv4jg/cVsMYIpA5uIFJ88iTM+c+9iWiQCj18
	 mzX6Nh9ZLbztnGX/v6gCzbUWbbiqNJSTjoqWCR5UUtSEJyKkCUCIyXxJ6zp9gCQgFEu8R
	 42TkOjcEwKhbv3KFz1npZKxBHjXuwoZhCJW/O2uIo+5xiOCSHUVswo4uORn9ZfShiM+3c
	 UzzR5q0sDGFGuIDqm4pXdXP69kRmnXGl7J9+tw69u6MxV5oY74TcQ4JRrA8G/hVc/GQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SEHxRY4+;
	arc=none smtp.remote-ip=209.85.128.47
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED10A606A326
	for <linux-fsdevel@vger.kernel.org>; Mon,  2 Nov 2026 13:30:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ED10A606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SEHxRY4+
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4a5036bbac7so18113355e9.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Nov 2026 05:30:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793626223; x=1794231023; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=MbpiROGQuzVONeXp96zntA9ceKse3+uC6QJ979xAbqY=;
        b=SEHxRY4+KzlF6m4DVJJmK2js3aghhM7f1F1OLGzNkF2qUc2JiYeZdUC3SuJ3sQU9mH
         Qz7RC7owoB94WsmcCfeMS9/XimsNpNLyiqSf7k3BNTheWNaIjWmDWBzwUnIepRbv+Fut
         62wV+WS7tAy8GNU9nrQE2RfIbb+24NgGwcJar9KYvzjgklgf8ZzfD/pw1hPlFKyCra6s
         VNrhdpF5JwOjkv00Hb5XLGT5Xr/RFQw9tpzU5x7aJSNtdhkfrgdWY+Zm9yHPXow0H/dx
         rNwrnT24YmA5cFx59Dc7n2V7+NuFCNhWwzwvtkxs1O1ufTmdgpOOf4Bn3GzkQ9nRsfLX
         Kfvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793626223; x=1794231023;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MbpiROGQuzVONeXp96zntA9ceKse3+uC6QJ979xAbqY=;
        b=oXTvVGmIvQfkKPEPdH1Gg7vRBRVwknOiZ+uuGUv29y86Cp6PsDA5VEw/igZ2jsStxl
         ukk8RCco6VoPi0kbPug3fd/Yup8NxSk7k5SPoqZm2UU3AquMTK6LvqAODmaJ/hleA2pa
         F9qkGKv/xO3sBHocOf3IS5LkFMH7cK+pIee9IyaLah9ZVzLwVOl6W1rO46d9ui5nTww0
         QK7w0WUUGzalX9GAFAAvgR0zkY3R0Cbex9sLFOwF0lxOXrBdVtnxYAr9HEbiegi3chFp
         +hDBj1ozKf72pphxTbFB2CqtFZJCTeTNXHIeC4D9gC31/z38oD+KZi/lojal7+j4L0Xo
         qvkQ==
X-Gm-Message-State: AFq9FYJKENQRsE3Lo03AqL2CIdl4wXBhXi0QliHpbyJFJjJ9L81wdWDH
	syEwxa6GedDzrG9VemNBts+jlS6C1VeGapL2MOymRRMchHAanOdXQAo8
X-Gm-Gg: AYBFou0IHhX80pUHOmWIB/4EorODbbU48s51ier/Ot6HqqoT+soEDfNMvN/QH/e8ZV9
	EfH7Do40pBx+QjX3zeCrC+iVmsWO6enWVTz/JUusIHMVKZTnhy60FPvcPWVDUqkXqXxk830sw4t
	TrRHBlcDgUcHCrLvz1XnLRY2AK8L+YvfdbkDJzj5CO8ZTYNidwZj0KqThvVF54F0KB6kVt2/83R
	SiK/tu9jcwQfrgyUa4AyXLqTiyrwGJurWYQkoOEoIYYPZcYxfzyqHlI2+4D1LU1jy4MeNPRysCo
	uTuhj0xOqHOKY8BY5juREyUoWp9coaU1W4OJXbgABmJOWaQINUg069yEKVSPdDrit3Na+oxw4UF
	2Hc6vk5umoUIwo0tQC4D1ulqAGSq8IyO+UTLKuVNCu1siMzA1oT+0aGOMOqHArZR/4f5/8ThinF
	Q7QS5F8NLzk4yDylsaYirh43nTjAYIhbxKvEEAYGegkS/9c4UpoYNbfARTC8XkhP33l4SR+La/x
	afpgy8uzp5cAkiGxKMaz9v9NHa/r+OMwklNkkJTu67VwB3wzbsMbxIn9Zoiza93Z3vaI6sSPorJ
	gruSI1SkcjTsq5XRhgv5n27vK4/TNPLn4XEdkybTIxGuyMEacKqiengK8WdvtKssz0bw+HG3s4x
	3NnRZS8lObXsY
X-Received: by 2002:a05:600c:870f:b0:4a2:1612:6367 with SMTP id 5b1f17b1804b1-4ac185bcf74mr220454775e9.15.1793626223025;
        Mon, 02 Nov 2026 05:30:23 -0800 (PST)
Received: from localhost (178-84-201-199.dynamic.upc.nl. [178.84.201.199])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4abf60f1076sm291182855e9.6.2026.11.02.05.30.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 05:30:21 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Christian Brauner <brauner@kernel.org>,
	Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org,
	linux-unionfs@vger.kernel.org,
	kernel test robot <yi1.lai@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH] selftests/fscontext_ns: expect EINVAL for overlay descendant userns create
Date: Mon,  2 Nov 2026 14:30:20 +0100
Message-ID: <20261102133020.3341462-1-amir73il@gmail.com>
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

Commit a518e63c3775 ("ovl: return EINVAL instead of EIO in case of
mismatched user_ns") changed the errno for completing an overlay
fscontext from another user namespace. Update the overlay test variant
to match binfmt_misc.

Reported-by: kernel test robot <yi1.lai@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202611020115.2281e158-lkp@intel.com
Fixes: a518e63c3775 ("ovl: return EINVAL instead of EIO in case of mismatched user_ns")
Cc: stable@vger.kernel.org
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 .../selftests/filesystems/fscontext_ns/fscontext_ns_test.c      | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/filesystems/fscontext_ns/fscontext_ns_test.c b/tools/testing/selftests/filesystems/fscontext_ns/fscontext_ns_test.c
index 0f30a3e6e197d..535bf1f4e1a30 100644
--- a/tools/testing/selftests/filesystems/fscontext_ns/fscontext_ns_test.c
+++ b/tools/testing/selftests/filesystems/fscontext_ns/fscontext_ns_test.c
@@ -193,7 +193,7 @@ FIXTURE_VARIANT_ADD(fscontext_ns, binfmt_misc) {
 
 FIXTURE_VARIANT_ADD(fscontext_ns, overlay) {
 	.fsname = "overlay",
-	.expected_errno = EIO,
+	.expected_errno = EINVAL,
 };
 
 TEST_F(fscontext_ns, create_from_descendant_userns)
-- 
2.55.0

