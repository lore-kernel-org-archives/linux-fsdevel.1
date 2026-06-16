Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D49461E3DDE
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Jun 2026 00:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781570256; cv=none; b=W9ODjh3J2hUut0N1Vi36WRS9Z34PmG96yCEKAXtnm2pxejAbBki2vA1JydSKjTGE8972n+BOOuZmSNUXi8POnYFo8Ca9hji0vpPxK1lH42chzYgtajec9HLmuFiXCld6nXnu6lvtVy9+pUHWRUT7kXkI5bvfB6xQV3NQ1C52jU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781570256; c=relaxed/simple;
	bh=p91yC0380ci6RVyhXJ1kuAXKj9VL+EWnmfNds5Mm5/U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cRgmpETIOqu2jQX6vKjF9Ttx/OEAXQcFTzTj/KtI+imZ1wA3Nano1TOfFJgT1P/AU7cDcLcHK+S+5xY1JB37GyprN+VN7+gD6vcXdQ4ueev1TLArNsxDCjUDKMPcV8Z/aEn0hPaGYlXUW3LO3t/kGTcuM5byQpVC5uzglsM5nW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cXKx2If0; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cXKx2If0"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-490afc47455so17491795e9.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Jun 2026 17:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781570253; x=1782175053; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iFPF4sC2peklNMGORgGTd/4IxXXegAkw7S2lBmPrG1Y=;
        b=cXKx2If0O5uoxGazgOHP2e49iqcvTwTtqYvtYQ9fxEj297PwBpNzV1VGOo+P1bkdGZ
         pL8m/dAJG5/eXlbYJAe4BGkMPFSh7fZJz4GaymjDJVG2iiqVkXPONzbNYNblUaCt9IcO
         3ZPVUlbW/pCjck7mIZNaubCIpo/sWpoKe5YBxE7W+GmPlVgY5Yq4pZuUqcRCHJsZgFfh
         FQuLtOkUOb+zRGi5yMdTORX5WquRPRlKfP9mJi4fBnyLdTpx8lV+dSfDbhxM1yVUJ56d
         yXkQuOJaIe+9pzY1LpC+7WX2iP94q9CkdvyMuevov+StNCINA/hSlxgm0j7bZV/ge2pe
         upqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781570253; x=1782175053;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iFPF4sC2peklNMGORgGTd/4IxXXegAkw7S2lBmPrG1Y=;
        b=ameYIicBkqG/lu1dDY0f0xLvaxIwMqOvjqibPBDy38xAdQlN8Y7tDdECO/NJu2X5i6
         HSgju5L/zGuwgFx18dVq+4Lskf1ExHdAvGpPtsZF1MYoXXqxCZ2ICGHdpQZLydGu+iZk
         hEWOQoZn/dUgG4jdEw77jbBDzIAgLaI1+qP8m/EINtkIFw3z7AdQPDPiPi36uMHynNx6
         1n0ZSSuUrbaIvJUAOyFQ1Ok+vsAm2EKwnSMXmMBv3mj9v3UHdZPiR0u3SHgYhYxLt9YU
         kI2fMgPTW7Na2WSuKelW9y8vGuA1kOLGO+a3pl3/H09JOlL2r44sZQ3eCBpPqrdaukto
         r22A==
X-Forwarded-Encrypted: i=1; AFNElJ8TRNqaOVyKhkxv1InBjPXswa8QnUPJiLrw3mINNUKpGzA8Y1++WAPqoSM6OAYi8rZuagClbOXMO62oPfL5@vger.kernel.org
X-Gm-Message-State: AOJu0YyH00B07D1BEypTXSekPHjpIf20y0MnRWObLzOAE7nWC70OcpyP
	tj3Cb/UUCy44aWnM1UCmvOP4Bwj3DosR2sEKuLDrGYFj9ZEl3WOrWZKk
X-Gm-Gg: Acq92OEM95PPNtPb9XLjvI5YdhYGcPMevPE065VMUMLvv3XnfuGNeNVl09sLcQUNnVx
	l20DcpdCRRTQuPvEZuDf1/upSBL9moNCjqJ6DNMqkMbEjdVzFx0nEurpfNTgWRtwB//t3yDo3Z7
	izUF63FJwrR1/J0sbd0DM9udv5hv/3e7ukvnGsdT1/GrqUzNEMiUiR+FAf5uQm7yCKH+9e81Itd
	MaGldYJLVWveodPzsaP7Ao/ngs2RTBoJ13rzOVkde30gKleU/q7xUS5Bf5KRM5UkW5y24CpBlHy
	sFMc2O3pYIleNZhvUY07tlNV3FrlFHunK7rFW2H/9NRQym8SZnLewC5gCb+ZyI5Gfsn7zF5Uo+K
	8cbMof2rc/UOYQ6GLgSzUsBgR1HhHa7o8FJslmUvXW6/JHOqjPvLn7s87Cau+ZCYn0yg40p1iig
	cdNlB7HCZT6oCi4o7Eyh8=
X-Received: by 2002:a05:600c:698c:b0:490:b025:f324 with SMTP id 5b1f17b1804b1-4922ffbdad4mr19600415e9.32.1781570253120;
        Mon, 15 Jun 2026 17:37:33 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-490ea4b39e9sm238270495e9.0.2026.06.15.17.37.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jun 2026 17:37:32 -0700 (PDT)
From: Askar Safin <safinaskar@gmail.com>
To: agordeev@linux.ibm.com
Cc: akpm@linux-foundation.org,
	axboe@kernel.dk,
	brauner@kernel.org,
	david@kernel.org,
	dhowells@redhat.com,
	hch@infradead.org,
	jack@suse.cz,
	linux-api@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-next@vger.kernel.org,
	linux-s390@vger.kernel.org,
	miklos@szeredi.hu,
	netdev@vger.kernel.org,
	patches@lists.linux.dev,
	pfalcato@suse.de,
	safinaskar@gmail.com,
	torvalds@linux-foundation.org,
	viro@zeniv.linux.org.uk,
	willy@infradead.org
Subject: Re: [PATCH 2/3] vmsplice: make vmsplice a trivial wrapper for preadv2/pwritev2
Date: Tue, 16 Jun 2026 03:36:59 +0300
Message-ID: <20260616003659.4002764-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260608171917.3195488Afc-agordeev@linux.ibm.com>
References: <20260608171917.3195488Afc-agordeev@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Alexander Gordeev <agordeev@linux.ibm.com>:
> Hi All,
> 
> This patch as commit e2c0b2368081b ("vmsplice: make vmsplice a trivial
> wrapper for preadv2/pwritev2") in linux-next on s390 causes the selftest
> tools/testing/selftests/mm/cow.c to hang:
> 
> # [RUN] vmsplice() + unmap in child ... with PTE-mapped THP (128 kB)
> 
> Recently there has been changes in THP area, so the problem is not
> necessary linked to this patch per se.
> 
> Please, let me know if you need any additional information.
> 
> Thanks!

As well as I understand, this test uses vmsplice to pin pages.
I. e. if my patch lands, then this test should be rewriten to use
some other mechanism.

-- 
Askar Safin
