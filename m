Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0C463FE644;
	Thu, 16 Jul 2026 13:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784209407; cv=none; b=F+IqfsLyAS1GBGK2xd2F4zaawmpnUxqvgZmZMrzZGzDgxObXEVc2Cmol8lY9Lbl3LNq7eMDkpMyk3Op3hnN16CNw7MOACmYNFELsWcGi7OmQhpXHhX5oXsRozeiEZi01sJzzMG215IX4rhHMBglVXneCGWZxq9C/MBB6MHApJfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784209407; c=relaxed/simple;
	bh=7UI0mIFYG+mIz3byt2ODgMg+7CLGrncE3i/GKe5ys1E=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=MsV7Lyr6At9wMmQUN8s3oKFgS/sYeycuXvzyX39d4jDM7gokxRgw/lDLXVARQhl0W25XiH5dLBRP8lpN4HOrKsLYNy2dPBjI+H3oQFLy5h1vpjB8DUooQRCkKjWm82xZ7wcHd8Ptxd/mc90aBmX888ZDh+GmtYe8eeFeg2bt5EI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eFb4A2up; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eFb4A2up"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B7EF1F00A3D;
	Thu, 16 Jul 2026 13:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784209406;
	bh=fZPKYsDRJG+4F9Azuo4iLsk6UDzXDy61m+XGdUaWSw0=;
	h=From:Subject:Date:To:Cc;
	b=eFb4A2upc+DNWmXhR/oZogBtUkYdnnGheADoFx7GNvy2bCkPj3gNkoPpWJkqkvovT
	 kduGbGrcvF0X1xPGJCaq1p+t19sjqwU8pBOwwIrrUTBwEg1v6yN/5ZQ4w+Sbu4a+jg
	 9xyx9U/1ePKcJ7z/4FZMNWcQr65BHzqcnajCnSE3NiYJ3rGqGDCRmW7qj9lH6bZOAS
	 VuSbLWtAyR5PkCiXtaavmaVsklIiqO7TCPnZREMi+/jOZDSokWiv10YzHaE/MWsq/T
	 LtC24YMzRFnX4tvAKvNZ+Alq6mDDTsEN85vwmu09FktrYSbqz96wdPw1XO8Mgq7RQv
	 oSp8g7uEkHlUQ==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Subject: [PATCH 0/3] mm/mseal: further cleanups
Date: Thu, 16 Jul 2026 14:43:08 +0100
Message-Id: <20260716-mseal-fixups-v1-0-3a9609bf041b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOzfWGoC/yXMywqAIBCF4VeJWSeogWGvEi0sp5rohlMRRO+e1
 fLjcP4LGAMhQ5FcEPAgpmWOUGkCTe/mDgX5aNBSG5krIyZGN4qWzn1loTLlvLSZ9aghXtaAcfl
 yZfWb93rAZnsbcN8PJkyi3nAAAAA=
X-Change-ID: 20260716-mseal-fixups-131ad0939de2
To: Andrew Morton <akpm@linux-foundation.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Kees Cook <kees@kernel.org>, David Hildenbrand <david@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1186; i=ljs@kernel.org;
 h=from:subject:message-id; bh=7UI0mIFYG+mIz3byt2ODgMg+7CLGrncE3i/GKe5ys1E=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLIi7n+8u3lWve2EY4p11opp1pO2vXjmuE102n2RVysN2
 YOZMkSzOkpZGMS4GGTFFFmefxHfHyQSNq/zgr8bzBxWJpAhDFycAjCRrfkM/0y6X/06zHXu8PYJ
 3O9+b469vmK7+aKtwmzPL9vNyDS69/EYI0PHFMawV46LtRt9ujY9Z/7PeS2g8bUMs9E2GYewx8/
 YcvkA
X-Developer-Key: i=ljs@kernel.org; a=openpgp;
 fpr=E7F417BF5214569E89D04F46CF9DCD8A81E27F14

The mseal implementation is still rather confusing, so tighten things up a
little.

The only user of do_mseal() outside of the system call is the MMAP_PAGE_ZERO
process personality - retain better control over how mseal is utilised by
providing mseal_mmap_page_zero() for this instead.

The comments are overly long and confusion, so cut them down so they're a lot
clearer.

Remove confusing mm_struct params (mseal can not be used on remote mm's) and
wrap the actual system call logic into the system call declaration.

Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
---
Lorenzo Stoakes (ARM) (3):
      mm/mseal: remove superfluous comments, fix confusion around mm
      mm/mseal: limit scope of mseal address zero to address zero
      mm/mseal: remove further superfluous comments, do_mseal()

 fs/binfmt_elf.c    |   7 +--
 include/linux/mm.h |   8 +--
 mm/mseal.c         | 156 ++++++++++++++++++-----------------------------------
 3 files changed, 56 insertions(+), 115 deletions(-)
---
base-commit: 59c684a9908d2e6f7a791f7f033eae57ec2b3a61
change-id: 20260716-mseal-fixups-131ad0939de2

Cheers,
-- 
Lorenzo Stoakes (ARM) <ljs@kernel.org>

