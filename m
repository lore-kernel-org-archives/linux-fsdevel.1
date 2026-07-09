Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D52A330666;
	Thu,  9 Jul 2026 14:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783606871; cv=none; b=RjB1OMl0ID4EqeNRYwe4+CtnuoOYVwnABIZKQk+yXTSkMn8zHZqmaTgdh1goHPCpes4bKDM91vXEuGtedMOaNogxDKe2WG0bVca4Y6GyAwyZDn7rofGHaKVGi5fXLO3R++hlapVE4bf/8fCCPas0QSzYJPAestsK335yGvsT7Uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783606871; c=relaxed/simple;
	bh=L62gVPkZlLKhXUcpda/PGKhTn2krIxmg3JtDHcRaOtk=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=S9azj+ccnQ96mnZ2bW0SOH364SL1YooGJS8KL/Es40s/O2Nj9Nr61vorsyQXdszgsr8TzpOyjkS3a16+623bEG+mL+wo0RmCrjR2NPH/VpAjTjLLWsAk4NCZr69BvSzpaxgMoVKcuXjtLfpSVn607vpCvk7AG8CmFFF1kUlFoQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lpG6R6c+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lpG6R6c+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B8FC1F000E9;
	Thu,  9 Jul 2026 14:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783606869;
	bh=ksWqnTka8bAb97To1RZgDSezrwj+Cz+GSo3hApHDAJo=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=lpG6R6c+71UGsDrGNhed2CHelpABmw4iGLDDIDRuZLM0cZPibiHJsKOsaCPmg5udE
	 5+tJs+Vg3mYmUoiz16lwYOmpWV1JsVFypLrJZQvbHULpEY3w/AnMd1CVtlNa0MjDl0
	 u3XC+kBLiTtodVXmEIl/p4rpDHFc9wt4z/8xuY8Qo3pVhoQI9INGdLy0uf/qfcZRwI
	 WI4yVejq9WlKSs4WNIIfIjxTy5ZqjiT9K5jJPHRUUZSZLHA27FM1ObQpFVwSUYG+VQ
	 GvY/B0PM7xwYaMje/Kumb0yUALm/bGsLfA9YQb6jDUpPRmTpw9jHuzBryTpZOvEO0x
	 DJoPm43F5OYig==
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 09/14] vfs: add O_CREAT|O_DIRECTORY to open*(2)
From: Christian Brauner <brauner@kernel.org>
To: Jori Koolstra <jkoolstra@xs4all.nl>
Cc: Christoph Hellwig <hch@infradead.org>, Pedro Falcato <pfalcato@suse.de>, 
 Aleksa Sarai <aleksa@amutable.com>, Jeff Layton <jlayton@kernel.org>, 
 Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
 NeilBrown <neil@brown.name>, Amir Goldstein <amir73il@gmail.com>, 
 Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <111142800.451666.1783594280454@kpc.webmail.kpnmail.nl>
References: <20260704164149.3480051-1-jkoolstra@xs4all.nl>
 <20260704164149.3480051-10-jkoolstra@xs4all.nl>
 <akyyqnv9EpY7xVdC@pedro-suse.lan>
 <1464441345.181098.1783418805206@kpc.webmail.kpnmail.nl>
 <akz_Ik8_eTnXav1H@pedro-suse>
 <1400609680.217714.1783433931054@kpc.webmail.kpnmail.nl>
 <ak5rHOsvtMX1j7S3@pedro-suse> <ak8-lSfOy0oL78N9@infradead.org>
 <111142800.451666.1783594280454@kpc.webmail.kpnmail.nl>
Date: Thu, 09 Jul 2026 16:21:01 +0200
Message-Id: <20260709-skigebiet-fakten-galopp-29f4f1170f61@brauner>
X-Mailer: b4 0.16-dev-4217c
X-Developer-Signature: v=1; a=openpgp-sha256; l=723; i=brauner@kernel.org;
 h=from:subject:message-id; bh=L62gVPkZlLKhXUcpda/PGKhTn2krIxmg3JtDHcRaOtk=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWT5r/OvfR89o6rssM1XrfZrTQmd+tOaXCxSGCTcuZ1kr
 89qW3Olo5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgFYCJHTjD8Mzpck+dya3FwrrZJ
 ZVdD0IMzvsnbf3kLeC7U/NXjfnmZCyPD1K49pYeyfxtfa5gqtvTnWd1aNZ3/afcizi/Vm3A4ukC
 CBQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

> Maybe just backport -EINVAL to every kernel since introducing openat2(2) then
> that can be used as a test.
> 
> But that is an issue if openat2 is blocked. I don't know enough about blocking
> syscalls to know if that is a big issue or not or whether it can be worked around.
> But something like this seems reasonable.

Please just send a new version with the relevant issues addressed.
The last comment clearly didn't even bother to figure out that nearly
all LTSes return -EINVAL for the combination. 5.10 and 5.15 fail as well
but are broken because apparently they didn't get the actual backport
years ago. They die in December. And upstream doesn't care about
Back-To-The-Future Frankenstein kernels.

