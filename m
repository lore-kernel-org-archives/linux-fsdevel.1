Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3C9317177
	for <linux-fsdevel@vger.kernel.org>; Wed,  6 May 2026 15:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778079725; cv=none; b=brYaKZ0aeEqGhgrMkZRjQOs8hr0fVAtwtvJcQIMEZMS+1ODAf52NJxMAoT9v1F20e9BoyW5rUXuO8vhwQUW+CgYafVPLC6+SuQT0wqITFHpbpQmdazKrLzyT953onpZHlNJsssxQqq7dY0iDqZEHewwkOxxBw6HE6ze6xjjvxpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778079725; c=relaxed/simple;
	bh=l5zO/XAUzDIt/BzOjb9E9+JdiVlDpN7L/iEhqOAcMjA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=dC2a1aYYN70uNxI6fQirD9xuqGT5mVoXpFF11tB9+11FGi6JAkKC3XxxPspn1tRVZFvVHy5/w2WPWNAK3rcWCNLhBv2Zet4LzQ57o9drwb692feH3xDiM0bu7xnlXbmAQm0OsztPrkmZ3beQ2wQdKqcl4/1ImBE7lVRvMywdPMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IPHixf8q; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IPHixf8q"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4891f625344so11658815e9.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 06 May 2026 08:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778079721; x=1778684521; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vymH9jvFkd+f4AV47aojtaQEQA7/cw8LLkGt+TrxI50=;
        b=IPHixf8qn9HZBaCW0tzLjt2lqPZ5GpbGXKzfPunB3JZQ+x/G9dC1ZetCeeMW5TFizt
         gyya5LgXW2xZt/20u/bD47QIas2ZTjsTQiTYFKwKsjSrVfLBIhvdziFfFh68fFKrb5j3
         oar9YJYHcyx+ehUDZNmtT1bl9R4fZQNSWzDEaRq/fdPlm1kL8Llp1H1Q8uPGjVlsr98U
         5DxCxcExB1yisI4P2N338rNx2DyKDkVecbH7oGZPCvNfsr2NjEq4bZmD8NNPEusuYL2H
         dTvdrzU4P+NNAoA8rFyvq792X79QAM0Oz39OYUxTQn7tYW+p4RNiAPFeqet5dChxc1wi
         lPkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778079721; x=1778684521;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vymH9jvFkd+f4AV47aojtaQEQA7/cw8LLkGt+TrxI50=;
        b=ay3rmAq7kMbg719j447GNubeXyMgntIPvho44c+Dr3KvyTuMUzpF6Db1n1gUdaRMb0
         ndRtgFqIEkZtMTztHC687kQ73DXRuFpBp40dqa0OIUOMc6xhO0qnIm9Qsqu2hIMRK/iB
         g49jc4IYN1TgWtuQkl18MGfRnS7uOuWpKkuCAUka5vGnO5mXExKIGPYJsm9dTBBOWvGW
         d8VFeVM6tob394zv5b3A/yVelWfhDB5gDRaN4fxF0APcWS2PdRutsGvT1kNbhDkfpZSq
         NLbkuSBRkK1hoHN/Njn3+naX3JKvX9b0v6u6At7gFKFbPIcE6BEIPx93X1ufosMq6P6v
         Sy9A==
X-Gm-Message-State: AOJu0Yx1uqUIHpJGdOrO2sxwF1nLMwYnKmdYwIHfPkW4Kvh/kQm1zo48
	E6n6WaZgXvzmN2nTJ2kzc01hD23aYLR5bXWy+ZejO7BXAr14n1CMHiI=
X-Gm-Gg: AeBDieuDWA6ijvnSx3mt5cOLYxK0TOaKE1HFupjNHNu9JmT4dIjqXGqxHZs3K+8sc/7
	VpwU0IPCF/yCWCf1144ALJU3A0lfFEcS2kPax0jL+vSVgnLc3YvGlk3RroloUWusENdNpCN3R4b
	DCJz+90NAhes4P/mRWFmB9P8M9NUqfz5dIursmkje7ohIYjh8s7EQZrrdET++9iGlO4y2ghJXHz
	IsXhzie40ZrN9sMZUkR9u6lstg2SFziYYTK6qQgrJnJIh6krn6fYPYEeYKWzhF3TuWznuhL5Rsl
	EGfRb4yLrLH60TKTDu1yER31r0z8WiaK/Sl368i2K2McHde/WgNK7WO+aBAnH6ZtLClYFFy1/j7
	Q0Ib83Edi0CCIsrbkztgdB1bVVNBaPjD9UwzOraVtbvSXnU6Bei6a91KvAqXdvympJbEJ8aUGXG
	RUIDmyooAvFKkTOY0O+eX5dXRtRZzSonqmWGj7PEL3XJzVnw4lQ6YJkJ4L0BNqFD63k/oAmI1xV
	sc1og==
X-Received: by 2002:a05:600c:8908:b0:48d:50a:6ef4 with SMTP id 5b1f17b1804b1-48e522b8577mr37260115e9.11.1778079720503;
        Wed, 06 May 2026 08:02:00 -0700 (PDT)
Received: from p183 (dynamic-vpdn-brest-46-53-134-148.brest.telecom.by. [46.53.134.148])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e5311f891sm30310975e9.4.2026.05.06.08.01.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 08:01:59 -0700 (PDT)
Date: Wed, 6 May 2026 18:04:21 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>
Cc: linux-fsdevel@vger.kernel.org
Subject: sysfs: upgrade OOB write by buggy .show hook into WARNing
Message-ID: <5f794f46-5afd-405c-9747-76f2c95d4598@p183>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Buggy .show hook will get just 1 line of dmesg:

	fill_read_buffer: ext4_attr_show+0x0/0x600 returned bad count

It may or may not oops later in some unrelated process.

But buggy .show hook most likely is corrupting random memory past sysfs
buffer therefore deserving more. WARN, make it more visible and let
QA machines panic earlier.

Also, delete useless cast -- "count" is >=0 at this point.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 fs/sysfs/file.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

--- a/fs/sysfs/file.c
+++ b/fs/sysfs/file.c
@@ -70,9 +70,8 @@ static int sysfs_kf_seq_show(struct seq_file *sf, void *v)
 	 * The code works fine with PAGE_SIZE return but it's likely to
 	 * indicate truncated result or overflow in normal use cases.
 	 */
-	if (count >= (ssize_t)PAGE_SIZE) {
-		printk("fill_read_buffer: %pS returned bad count\n",
-				ops->show);
+	if (count >= PAGE_SIZE) {
+		WARN(1, "OOB write or bad count %zd at %pS\n", count, ops->show);
 		/* Try to struggle along */
 		count = PAGE_SIZE - 1;
 	}
