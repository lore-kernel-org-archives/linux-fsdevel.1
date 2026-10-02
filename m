Received: from mail-lf2-f13.google.com (mail-lf2-f13.google.com [74.125.229.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8569B3233E8
	for <linux-fsdevel@vger.kernel.org>; Fri,  2 Oct 2026 19:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790970746; cv=none; b=tiGJDMPwAGCZQWf+h5qvzKjNq7MqS7newYzyO/nQEp1y+CPZ6U3jcTlCcbMart5PNkC42S4T2A3EYXRLcjLaVLlnXOQdRXfvOW9BLqRRyaC0auJ4GhEO2MkVXHOLWa/84HT/6Q1VfBqNWp77O1AVzNArDBXLMYBtK4bEZaVAD2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790970746; c=relaxed/simple;
	bh=1pz/Wdo0F/plk/TB9aAPZzG5xY7aJ6XToYfrVOYGCCM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D0k7jJVNIQ5N7RRmoY/Kl/Dy4pdsdgorEbrLIbl4BlmmzeFpVaSwRUV4l+RPBoFLYQlO1mQhTXLisPtweGWHM4TPiinbshU1Zq4+klVfrsggNmre3w5nWMWfujcpZw/n9pvI9lrENGTEC69nB7RsR1X+XcGb3Gn78vz3UGvYnFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=noroxi.com; spf=pass smtp.mailfrom=noroxi.com; dkim=pass (2048-bit key) header.d=noroxi.com header.i=@noroxi.com header.b=BQx2lQDf; arc=none smtp.client-ip=74.125.229.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=noroxi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=noroxi.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=noroxi.com header.i=@noroxi.com header.b="BQx2lQDf"
Received: by mail-lf2-f13.google.com with SMTP id 2adb3069b0e04-5ba44044ff8so2482911e87.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 02 Oct 2026 12:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=noroxi.com; s=google; t=1790970742; x=1791575542; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1pz/Wdo0F/plk/TB9aAPZzG5xY7aJ6XToYfrVOYGCCM=;
        b=BQx2lQDfNia+9V+O5D/Lew7+1GFpDCARUh3CrWyVzOhd5HGhdk7sYv785jY/f/VRY8
         h/bGMUxClnSNj0InCXoknHvhP6Ii7qP//mPEbvId4o8PJ5k7VXavW99GXrTGZmga/XDT
         +tDunV7Cdg/DFN4+j3InV3vU1+h4EmRX0L9QdjN0PiSj88VbeNTxmNRqfCu1sLvXWbOx
         T5GtfrSTpGgEKEc8ePOy92F5VtqWKDagCJqX5UeameD+uD1e9VbrMJJ1+8XVAejPYdh8
         HcmvQ2+ADhtGcDmmPZy1MS+ie1WWd5eRpog6fk3lb4DEP2dIFf7PqHS49q42cKmODSQJ
         oP3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790970742; x=1791575542;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1pz/Wdo0F/plk/TB9aAPZzG5xY7aJ6XToYfrVOYGCCM=;
        b=IjySaFOxv1lRLM/1Fx1kywLfLLQBCUn9zl4jOmutyczKhRU69I332cH12yBYHEOdBq
         8UB4RReCgfxbGtBF0yVYqnHhfTCt1p+TYOOFBkQ7Fwr8QuxFl/w2e93zHjsJuFkWqC7X
         O15ZdLrby7JXjCMRqpbymSymIS3pb3UX+G4sOn11HhqIn6bdMohS27SBLue4+uKERbbX
         tDHQa5yL6s55nGq2sOxpGDwyFfBkNidXw5t103aFJB/e/3vI0Dc5NmJsFRsyscP0KQ60
         LWCXRHrD0bA64jQ5rWUE742SS4ADgh4C5JY8rr03R68gOTQKLsjMCCaYWHd6vKbqRZnC
         4PPg==
X-Gm-Message-State: AFq9FYIZt9AU3c60j1ihM/Zp5QInOtlAgJIm9TkrNkzyi6V0hP/+tn5W
	XiXbCAwGmRyICJDgKcjkcPOhTF4/SFkOrqkv9gFMsg8NI2ssht0p4HvRUIQOy29IwUPiCkFpIRX
	kQ735j0EOhqdZ5A==
X-Gm-Gg: AYBFou1PNjbh63aE9YAjhzdDWB9pn0FzUmNXpQe55j8Y2tRj2SeIMRrnRa6kaaaAixX
	St+e1u3/qSdf+G9ucn10wq9NSPtKViSwqxId5/sK5Xi3HNdMMUfOg2HEOW428lgUl+AW9vNw0QA
	TNiwquUXjR8exSOkDFE2xUAMshA9/0QWTKKA8Kcnuou6gsssgFrU1+Nmg0aDxyqTBawOW/75ujH
	myCRZn/6BOKMlfJIc6qUPOdx9Ph5xenEjzeV97ByM9RQw0z3mGFkQmDvM7IDMW78vYvU4x760Zi
	FF45IpXjE/48miLiCbj7BN4CzX1WDNfLxaDcTTWCrXO/qiVEuV/z1BUqjz+t1XtC9wh+7mzHQQs
	ZJSSIhl3XuyJjk3pGqIi6iBJdS3CJ0ivH5bdGRUhkNxQcJm2TyIEIgMTRC0IIQfUb/Ikb8G7u9n
	jCrPQMnNtDYIaxxRMFZ9/zRvAmzKDZflPByb2xlQHjiTVs1Sd9nOdN9M37tI4NJ40zehvSrM1eS
	w==
X-Received: by 2002:ac2:5689:0:b0:5b8:eafb:e1a with SMTP id 2adb3069b0e04-5bb93808deamr1308545e87.6.1790970742251;
        Fri, 02 Oct 2026 12:52:22 -0700 (PDT)
Received: from lab01.. ([2a01:4f9:1a:a462::2])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5bb7c7a0b25sm1010928e87.60.2026.10.02.12.52.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 12:52:21 -0700 (PDT)
From: Mahmut Emin Kurhan <guvenlik@noroxi.com>
To: linux-fsdevel@vger.kernel.org
Cc: slava@dubeyko.com,
	glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com,
	linux-kernel@vger.kernel.org,
	Mahmut Emin Kurhan <guvenlik@noroxi.com>
Subject: Re: [PATCH v2] hfsplus: annotate extents_lock nesting to silence lockdep false positive
Date: Fri,  2 Oct 2026 21:52:08 +0200
Message-ID: <20261002195208.1564600-1-guvenlik@noroxi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <9f8b8dacee5d24c94185bab75ff905eb51a95999.camel@dubeyko.com>
References: <9f8b8dacee5d24c94185bab75ff905eb51a95999.camel@dubeyko.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Slava,

Thanks. You're right that tree->cnid and inode->i_ino match for the special
inodes. hfsplus_btree_lock_class() itself can't be reused as-is, though: it
takes a struct hfs_btree * and BUG()s on any CNID that isn't one of the three
B-trees (CATALOG/EXTENTS/ATTR), while extents_lock is taken on regular inodes
and on the allocation file, which are not B-trees.

Looking more carefully, there is only one actual extents_lock nesting: a
regular inode's extents_lock is held in hfsplus_file_truncate() /
hfsplus_file_extend() while block alloc/free reads sbi->alloc_file
(hfsplus_block_free() -> read_mapping_page() -> hfsplus_get_block() on the
allocation file). The catalog/attr inodes are not taken nested under a regular
inode's extents_lock (the extents-overflow inode returns early in
hfsplus_get_block(), and the catalog/attr trees are reached under their own
tree_lock).

So the parallel enum + HFSPLUS_FIRSTUSER_CNID check is overkill (and, as you
note, FIRSTUSER also covers folders). I'll simplify to a single distinction:
give only the allocation file's extents_lock a separate subclass, leaving every
other inode at the default. That removes the duplication and the file/folder
ambiguity.

Does that direction look right to you? I'll send v3 accordingly and fold the
same into the HFS side.

Thanks,
Mahmut
