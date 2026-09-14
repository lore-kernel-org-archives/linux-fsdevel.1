Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4753643BDDF
	for <linux-fsdevel@vger.kernel.org>; Mon, 14 Sep 2026 10:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789382420; cv=none; b=UdznM19bclsyFuYzicaXq5lcDoyHZ5RqXad4S9c/mng50xKGRls+/YhCkwhgp43uZlLvPt7YtkD7akUa8Nm2cK/XOzpROkNlcxbeJG0TN8Q01TRAz5QkK68lRflVo10qbVX3/Yl4JSXv1zgAsWhaqZF3iJMXTY4KGWI94Tb4s74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789382420; c=relaxed/simple;
	bh=xgPntlbUpUFdBKAdzHkHSWMx81IV6Nzl3C+5WbHu6IY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Zkze7/A4W4ApOJQsSzX3eysok63cu/RBoZePgB3Ewq78GR3N3IJHc34mMa53BRAwdKj35BQgV89NI+AFg66NAsK8JqsxgGSwDNE8TH9IcptBH/yFpnrGEFtMRw9MJqmIvzAW/FVKVr/EmlfTqD8V2XRW2ZOpNyXf4mT4Amz1h5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SvXKsK8t; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SvXKsK8t"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4998b5a63e2so34000645e9.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Sep 2026 03:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789382416; x=1789987216; darn=vger.kernel.org;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5Xb+w0dynq41gwCQksdLejtfZNR3cXeKsUIjY7qGZw8=;
        b=SvXKsK8t+WV0RpHErUkUkA6UZ2+URVR1nznKEaNxuig5hAhOlg8s5P2pflJx0TNOMh
         Zp8qmPR+fSvmlUHUFemyyAbUak02eW25GcPQzf9vdpR2VRGgPRdpdqxBMVNPDsw4xUJJ
         emSFe8OZoB9I767BXeg+YGd+St+LJoqsJpQiuV18J20TgOD7wf++7bczmxX6UhXZUOED
         tPwKubv3X5y7s7s4LNjHu9KNEf4dQey/oOAjfpGcixe49NOBaSbFe3RbZkCViNsAVK9m
         Um2888wmRe9xPdjKLh2TBiNskO2OYAEIpHrIw8UvpczUPRMlmpvnUdHNRc3mAwvP4OOF
         jETw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789382416; x=1789987216;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5Xb+w0dynq41gwCQksdLejtfZNR3cXeKsUIjY7qGZw8=;
        b=CJj5reZRAIrX6B4V3LrGyBnhPKlHl2F4XbC3XBHxZs/nlscCd0arEfIruLqwrVvsET
         f3GyRzzhk7bcAIuUaONexD6oF8WL6Xo/6glhRSm8rsAwp38tLYmXyNHgkyNKiDoLmORj
         z8KcHKTmCT5n6IAIJS8/d/tHnDLy/jD63uKQ+csxDW9LRVhO9s2QXdiTbwcIcVbTAcp0
         JJN95+CHbJ4hhH3mOaRE6xNMEo6998f27YRWtMgcqAFFvWEPTp4PQyBUkpka0Mma4hQL
         heYpdLaVwQ1ZqwmDcvGD7MJMkQrY47lAodX5UX2Vw6YDtQCR8vde1S4FVplQkYhrxTCx
         HS7w==
X-Gm-Message-State: AFuF++nRvR2jSEFQJLdh1O3FvrIo4FZdZM7trvMKV47wGaXgc6eEw02y
	rhYACJLnpR7XhfQZG1SPCvxrcH+CV7pZkbjzV9FPeR5+YX97xeAKayea
X-Gm-Gg: AYBFou0T+zEmzFzL/PdTVpHLZIqiQRvR9YkZUMaBHMRLbpvmQuWjr/tazuPtUlynTOl
	bgusAQluLLUAoQAJF7BAQiqjqAxOYIMN0PgBj+T2bj9cb123/jxnasoHBunOlF3+aPXSWD53Ea+
	onkNjci24by2ZjtTJLC2JfEqCxdfI1IiYNEynimOMsrm3I7rkc80KKqeAUsOZt0saWUtxyRPNI5
	XLaa/umuAzNtY4KsAD4nNY9HI7MUz3Vtfzsygo0/PWKMGHmVQgf4ntOr+jEir+mK6IJ2ZzT4ig6
	eOK7PigT1JNiLHQlfk0gjuY7iZK9Fa9iQ0t3D4uJKQpHjDUYtiuJlDpgl5KeL8w3xbzylH/Vg/5
	cScDi/ffxpMEI/opA64DIPC3p096ajDsjiVZJprXrLLsIoV82em0eD2VCKCsHAekPe7BLkg/KUW
	MVBCOHmS2rtwwQ6z0si0mSq/pe6bUtVq4mdGlaBThpcccoBDbLWERrRzIedh7YkHy3yoNJ
X-Received: by 2002:a05:600c:19cf:b0:49e:73d3:78ad with SMTP id 5b1f17b1804b1-49e7a6859femr22078775e9.18.1789382416215;
        Mon, 14 Sep 2026 03:40:16 -0700 (PDT)
Received: from localhost ([2c0f:3d00:6be:8900:ce5e:9212:ea4b:f30])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e7723d458sm105653065e9.0.2026.09.14.03.40.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 03:40:15 -0700 (PDT)
Date: Mon, 14 Sep 2026 13:40:12 +0300
From: Dan Carpenter <error27@gmail.com>
To: Chao Shi <coshi036@gmail.com>
Cc: linux-fsdevel@vger.kernel.org
Subject: [bug report] buffer: allow a buffer_head to point at memory outside
 the page cache
Message-ID: <aqfPDKwYQ3pNtVH_@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Chao Shi,

Commit 8deae2284976 ("buffer: allow a buffer_head to point at memory
outside the page cache") from Aug 6, 2026, leads to the following
Smatch complaint:

    fs/buffer.c:1118 __bh_submit()
    warn: variable dereferenced before check 'bh->b_folio' (see line 1109)

fs/buffer.c
  1108	
  1109		if (folio_test_dropbehind(bh->b_folio) && op_is_write(opf))
                                          ^^^^^^^^^^^
Dereferenced here.

  1110			bio_set_flag(bio, BIO_COMPLETE_IN_TASK);
  1111	
  1112		if (IS_ENABLED(CONFIG_FS_ENCRYPTION))
  1113			buffer_set_crypto_ctx(bio, bh, GFP_NOIO);
  1114	
  1115		bio->bi_iter.bi_sector = bh->b_blocknr * (bh->b_size >> 9);
  1116		bio->bi_write_hint = write_hint;
  1117	
  1118		if (bh->b_folio)
  1119			bio_add_folio_nofail(bio, bh->b_folio, bh->b_size,
  1120					     bh_offset(bh));
  1121          else
  1122                  bio_add_virt_nofail(bio, bh->b_data, bh->b_size);
                        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
This is dead code.

  1123  
  1124          bio->bi_end_io = end_bio;
  1125          bio->bi_private = bh;

This email is a free service from the Smatch-CI project [smatch.sf.net].

regards,
dan carpenter
