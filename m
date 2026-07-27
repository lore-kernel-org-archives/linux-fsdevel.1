Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3A23DCDA7
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 Jul 2026 07:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785138134; cv=none; b=h6KMzqq1ApXI53clSEEJXvPZ+9rOiqqF2x7kiCiFfOVkmysgkIXrTa6b2VKOnI/Ueqe45MKI5bKPqxo7U5YDHWp4w6/lujFGBo2ZZzzCphKQXBb9OwzFN/pVJFyc435WP20gcNCfeVfFDW/0SD5/GVxzZsH5tohSeiD3MgCTsXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785138134; c=relaxed/simple;
	bh=k3uuTmfGIyohz3f0+ucpApKqT9POBRXJbNmZCxQUDmc=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=ab/2GXAJs1tiaOE+F0Ffz5j30u519SLIhZ81FBYIReYWYvwF3gS0zxJNKhkPmwo6L1bBW3uqc/UEAzmKHFH/LSN4pJsdArj53Q6invrZFOegdIIwoJ3a5rgidnkxqdeXHtyHheq+RoWeKqXcqcp1HPx/gDWLYSZXsJNpryDz7Kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ejGDJpZg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ejGDJpZg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 958191F000E9;
	Mon, 27 Jul 2026 07:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785138129;
	bh=k3uuTmfGIyohz3f0+ucpApKqT9POBRXJbNmZCxQUDmc=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=ejGDJpZgoy4BylkHwgvCG5X+ECz1mF+YpaqZLfRtZ6unmm33wCgfQnjL5ILY2kdJM
	 GNVYB3EYR8D4tsVin74idXkHtx6VKOYMeU6LwWEoxX8dnO1t4qEKFATVnNMd/cQjT5
	 SU/BWjr8bUX1SLog0p225SIcjSGhqDu3cn3+q4FEut/tlNi+gOtXYB+mVLoeF16sLf
	 APqcEkQxEO7/ymObe5Gzy7k9kDP3cU5dG1hza841sp6j0f5fJYZ8Jd8bqgZKPXb4zS
	 +b5GHDGQsJ174X7M8BHvl+XV274HNkWuj8gqD45sVKvtx/DHM3ALg2hnfxhxl/WDqh
	 IaKhW3S9tuN+g==
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 09/24] binfmt_misc: rename Node to struct
 binfmt_misc_entry
From: Christian Brauner <brauner@kernel.org>
To: Jori Koolstra <jkoolstra@xs4all.nl>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-mm@kvack.org, Farid Zakaria <farid.m.zakaria@gmail.com>, 
 jannh@google.com
In-Reply-To: <amTYWb9X1B75lIdX@lt-jori.localdomain>
References: <20260710-work-binfmt_misc-locking-v3-0-a162f7cb58d6@kernel.org>
 <20260710-work-binfmt_misc-locking-v3-9-a162f7cb58d6@kernel.org>
 <amTYWb9X1B75lIdX@lt-jori.localdomain>
Date: Mon, 27 Jul 2026 09:42:05 +0200
Message-Id: <20260727-zufuhr-wahren-couch-0637f96a66b2@brauner>
X-Mailer: b4 0.16-dev-09492
X-Developer-Signature: v=1; a=openpgp-sha256; l=244; i=brauner@kernel.org;
 h=from:subject:message-id; bh=k3uuTmfGIyohz3f0+ucpApKqT9POBRXJbNmZCxQUDmc=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSlc5/f+sno01bj0kMWtwt3dngseHcs4J2D/EVt1/epP
 GwvmGoCO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACbiEc7I8Cz+gOQFls1VZqrC
 c4yXff5u2yPNLztlQcqVei2Dv0wTnBkZ1qheY9otU6K2nWMn1zoLz8O5bTP9vFNaM3Zma8U5dzT
 zAAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

> Reviewed-by: Jori Koolstra <jkoolstra@xs4all.nl>

One very minor tip. If you review a patch and you don't have any
comments other than you ack or rvb. just trim everything apart from
maybe the commit message and place it directly below.

