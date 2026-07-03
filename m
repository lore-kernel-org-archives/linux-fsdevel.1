Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C1F231353C
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 Jul 2026 03:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783049967; cv=none; b=S+vFqE5wDWEPz30s1mhGQVnzkJJOJwtoYQKzRuwAE5D+xZ6bzmSErsitZMz9uQydat347GwY9MKZ2OoGS9tcs866II2gZ06z8gA+G4A+QB4hWr7yrn1HzhKDA711hR5QxE+wThcx6dCiVS73qt52ZrPyEiVZVdFfuXrRg83go5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783049967; c=relaxed/simple;
	bh=EmOCe3dlmsY/xqj/qF3riy9y/Z0aLuKXGFjXqRSS+rw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AkbIvu91bV4FH/ZgV8UrRyfIez6XfYiK4qrx/yWNYhfllmx/HR6aL8F+1HbdjRAiEOCQX5Qz1KM6JmJzJ60SaHseErvq/gRVHMHXsL/jJsctSBNvQlfkSsVMKpB2wX/HCiQhmAkjXho4IuSggdMEbeyMdfuPRdhm6MDgOIBOhV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZZFvXZE1; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZZFvXZE1"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3812c718debso72446a91.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Jul 2026 20:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783049959; x=1783654759; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LGEbmGBP95wGa6K79zSaf3K/rpb1ObdZEZ70xmn01LU=;
        b=ZZFvXZE1BFoZEamCiMK1NBl+Y3rhpPSD9pr3qvZOOTabVfDRoVfEDi0MwUQxPyoo+x
         2WtOqpj4biO8dfXVp7jwGqt6AlAH4LJcj7nS4OhJ2vy96nQzbV5akKwUVqeuKkl4mGbS
         HANdLp+eraffZHVc3b32ZzpBhiFPX2Rq+Ya+MgjOMWaw01VB9DA1l+nGb0KSLyyVwC58
         A16SY9qB5aQsFmXCqRLeslbEMcS/1HIX2Uw+1Wha1ba649Wx3KF0uC7QfPUg4QVft4gX
         3du/k4jW2hu+QPeUF46LltqmR1nrzjgxUtBL8LkBMMTe8kSlxlvKTY+Cv9/bdPi5blLH
         aNzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783049959; x=1783654759;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LGEbmGBP95wGa6K79zSaf3K/rpb1ObdZEZ70xmn01LU=;
        b=ZrGkeN2fyGB5zWx1ieISw0lXBMPgdyYlzVxQlMs32xlek2RUCZc6LtO6NSF0l3ZbIg
         hFEsHS2FyRJi879Ev0CDlOKyCNK1c81uAur1kM3nnY+uygTxvPHCNw/f8PSp+cv/ykbC
         qRc/82XbSjzMt7h6cbkSJ2jgaoD/iVd9QjYv0aZzVg+BHGFtkRYdgEStIyA0Vc1n0tbu
         2nc4kuo3gGq/G7iepJla6B+QT8DrHfUTFV8VUVsxXSZ+3UAFiCaVoU7+m8yPIz4bsczT
         Z64Snx0+htbajLEVz2aKHtPM6oG6TF4VzRuau2gYYLPj75+BHOUcv4UNKE0f+wVy5Iuy
         +j1Q==
X-Forwarded-Encrypted: i=1; AHgh+Rp0TkgsVNe0EG7FBFHiUq0ixUV3EaLiTnKKU1AbI010tFy2qRZ5634QJ8t+gRXwVD40n2oORLJ4OMaKL5m9@vger.kernel.org
X-Gm-Message-State: AOJu0YzN+K5FPPXT3/gjjIFNdXUbdal/tAvxbQMxB8Nbuu+kO2+mg46V
	vqA69kHOG491U4nXUPo6GdCDtF2LXlaF/KMZyhKnvPdQJDl1jPD2dgjl
X-Gm-Gg: AfdE7clU1342bgG1Uw3kOSg/O7WcecNnbd4/UUaszMApEY4DjQ9Xkj+tiaL0QBXN2YA
	FcPFZdhbhUC+8p85EOXUvRLZczYb+WHpZeYP0/XuNbBRZmfeiihpci/E3Qz40GIYeFy9g1NLxnX
	heeB144RnTbf5u2kcOBH2EEFXxg43nUyA+TbtiLwzy3UoNN8h6NTSZPFfc0/O128PHS3qU9NDGb
	IU4Kp+47g83RsCzDg2wS+/e7dRaMdvuC5kJ3kdUcwe8xdwUVyb03FLXabjkgBX0u+Uc61y3ZGly
	Itxefp+QlJ+1QfQ3lW5RwRYyBRZy0M5xTG/PQYiLiXHi1cHVAbw+HyB/P9qjIHqXEY+nG9VwEgU
	aYXk8JTKQtFd4sITMSl+0t0hASrriq686GtmrKESWWDbEuHfo0AXZQZTvf/jV/PI4cJOuJ/KlAQ
	ZHj+W4FWRTuFtEAwlEUNIHiC04o5pFjZCteA9TQTauEPcPnP1n5keAWlA71ua10lo=
X-Received: by 2002:a17:90b:4d12:b0:36d:66d4:270e with SMTP id 98e67ed59e1d1-380aa0a8048mr9587437a91.5.1783049959073;
        Thu, 02 Jul 2026 20:39:19 -0700 (PDT)
Received: from DESKTOP-L3Q0GIV.localdomain ([203.230.195.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38127c56b7dsm294728a91.9.2026.07.02.20.39.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 20:39:18 -0700 (PDT)
From: =?UTF-8?q?=EC=9D=B4=EC=83=81=ED=98=B8?= <kudo3228@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: Sangho Lee <kudo3228@gmail.com>,
	Hyunchul Lee <hyc.lee@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [BUG/RFC] ntfs: crafted image triggers WARN_ON in ntfs_map_runlist_nolock()
Date: Fri,  3 Jul 2026 12:39:14 +0900
Message-ID: <20260703033914.98698-1-kudo3228@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAKYAXd_zqD8dGrApqpR-ZRvqU1JnVYaXLM9JH2PjJXaekgJgEQ@mail.gmail.com>
References: <20260701221237.822167-1-kudo3228@gmail.com> <CAKYAXd-+EKp98S2WMWNfhX0+fNfq1_3QrdSsnw7uav0hWXdtNg@mail.gmail.com> <CAKYAXd_zqD8dGrApqpR-ZRvqU1JnVYaXLM9JH2PjJXaekgJgEQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Sangho Lee <kudo3228@gmail.com>

Hi Namjae,

Thanks for the patch.

I applied it to my NTFS test tree and rebuilt the kernel. I then reran
syz-repro with the same syzkaller crash log that reproduced the original
WARN_ON in ntfs_map_runlist_nolock() on the unpatched kernel.

Result:
- unpatched kernel: the same log reproduced the WARN_ON in
  ntfs_map_runlist_nolock()
- patched kernel: syz-repro ran through all extraction phases for 29m28s
  and failed to reproduce the warning:
  - 15s single runs: no crash
  - 15s grouped/bisect: did not crash
  - 1m40s single runs: no crash
  - 1m55s grouped/bisect: did not crash
  - 6m single runs: no crash
  - 6m15s grouped/bisect: did not crash
  - no kernel WARNING/Oops/BUG lines were observed

The change also matches the root cause I saw: when ctx_needs_reset is true,
ntfs_map_runlist_nolock() can reach the runlist mapping path for a resident
attribute. Returning -EIO before using the non-resident mapping fields avoids
triggering the WARN_ON and prevents the invalid path.

So yes, this patch fixes the issue from my side.

Tested-by: Sangho Lee <kudo3228@gmail.com>

Thanks,
Sangho
