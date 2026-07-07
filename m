Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C9E3F54CC;
	Tue,  7 Jul 2026 10:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783421507; cv=none; b=QDI/zrc67EgPiYm2W0dd57UvCoRPsRGIVcl1co66q708p98WeJjoAQs3bIen6wp1g+BHm3OMBi6Cg08odCcU0YxhvnIheZJe7t1+MbtuZBj8w7rGg7zCZgKdGNoaGHfGMeB8Kd618VhaQlOl1n2y2Ux+8umAK0J9845IzXjMIXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783421507; c=relaxed/simple;
	bh=rQQu5voLZpvm7Bf7ZeQRcZpLhaB6ajXYHRyhNTigxtc=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=s1DeLbpaLzNpyefvo7NVQn7Kq8TQz9jFkAik6maceMaKiSYx+KvicFs/OKkvUVjyoMT/X9qGuTeI7V6luMwZGni/zwoVxvm0bcN2Skx2qzK+t/fZ1GDcWW9L2oQLA+Au8hl2LXMQ2JN0Hy+2abOUk8q9uxdtfmz3JsjDsDLaXrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BTXhs8Th; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BTXhs8Th"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE2D91F00A3F;
	Tue,  7 Jul 2026 10:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783421505;
	bh=XKInA13G8JmWz23cKyEkLQtiS5YuRh2RZy9YZLIb0RU=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=BTXhs8ThFHwq+pQzCLJO91JuIhTWaEZgcXAuMwIXvCb5ZX2PHqXC6UHaDH3yvq1Je
	 h/GMslem3DWwzPQKers6fIcFgjnoQcTgzN9xNA8CAPDItfq8a7hxbt00X5URTqreNm
	 8hdqWMziNJ0/MjKuVxNVxW9cnzxh2k7xU6zw5pbKIB3Z/sSW6YwQb6Zs/+6ZGOe6OM
	 6kcwKm+W69g/1p+/pbRYR+9NdaI1+WtHo3KL7Hvm+jjTggYMX2FUAfCIY0jj9GQmJc
	 8ombK0nxKMFKzuAW+oUlYZw4oxdpm65fTwfJs7slanEVKtAqQRbto0u0zEjsm/bj6F
	 wi7EMGXmENwfQ==
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 08/14] vfs: lookup_open(): use vfs_create_no_perm()
From: Christian Brauner <brauner@kernel.org>
To: Jori Koolstra <jkoolstra@xs4all.nl>
Cc: Jeff Layton <jlayton@kernel.org>, 
 Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
 Aleksa Sarai <aleksa@amutable.com>, NeilBrown <neil@brown.name>, 
 Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260704164149.3480051-9-jkoolstra@xs4all.nl>
References: <20260704164149.3480051-1-jkoolstra@xs4all.nl>
 <20260704164149.3480051-9-jkoolstra@xs4all.nl>
Date: Tue, 07 Jul 2026 12:51:23 +0200
Message-Id: <20260707-wirrwarr-besiedeln-agieren-ef72d6c5ade8@brauner>
X-Mailer: b4 0.16-dev-4217c
X-Developer-Signature: v=1; a=openpgp-sha256; l=520; i=brauner@kernel.org;
 h=from:subject:message-id; bh=rQQu5voLZpvm7Bf7ZeQRcZpLhaB6ajXYHRyhNTigxtc=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWT53DK47f5lcdDpIzPvL3l4WInv1Z5PKz0f+v/fXSSRN
 muGhfLBOR2lLAxiXAyyYoosDu0m4XLLeSo2G2VqwMxhZQIZwsDFKQATMd7CyLDP09xf069h/gXG
 xacSToZHBJ1QzNVsVBOaZ6uXlWFVY8HwT+G34BPzK91i1zKar4ZdVRf3nfw79pHSdj7THTburUy
 feAE=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

> We can replace the code in the no create_error/negative dentry found
> from lookup case in lookup_open() with the vfs_create_no_perm() helper.
> 
> It is safe here to always pass excl=true to ->create via
> vfs_create_no_perm(). Local filesystems always ignore the excl flag,
> and cluster filesystems implement ->atomic_open, so that the ->create
> call is never reached in lookup_open().
> 
> Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>

good cleanup

-- 
Christian Brauner <brauner@kernel.org>
