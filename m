Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF22C2AEF5;
	Tue, 30 Jun 2026 11:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782817279; cv=none; b=UjJzU/Mj9iez+Uco/D/1q5Km2PH0mArHCtg58SRUdFpdIwneVkuOf109CSu3eatk0X2xyocrdO3AiTXdf1PgrTCFr+cBI06lEulAmAG/KkRY9k/kz1StKQwMN9eIBS+fFQZsWKo+AMto0Y0RykmDrg8XCaGZcm0HG1ACPqAwf4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782817279; c=relaxed/simple;
	bh=otsWDoBxDw7OsOlA5XvX8DRKZ2AHTVTuphMVADKQBWw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=SoccdoK36Nqk3JWN/kTUUiZEasynUOtP1+jHCf9cTqyPY3w5tUSKQN71gYlIQlC6ga/EWShi4X+rRQstxTJ6YkKgYpmKahzuaPHXj0Fe6jEDQkTHRucV0bWOFYupZQIxvxRiO2dYVQ3JULj6KpreDV8sosvfSDhGSWMy5BGt+bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G75z48oV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G75z48oV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AE631F000E9;
	Tue, 30 Jun 2026 11:01:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782817278;
	bh=e3oV4MpsMt0qLRZYhZsnNTu39Bn17vFNVu9TpNVWVbU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=G75z48oVZwOOvQgiSLFhgh3nOrwsGkJPCXcZli4ENzfJG7hwG4i1vpaY9uHQG7I7M
	 hTKhEMR3ZMg9dIInTbzhAbHpANBlK6+iADXVFDqrkH7zRtGqmbrjW0mRPpA9VKoryw
	 JbuxVguef7RxU9dFTa6PRsBo6VFJQTNVdx1dA/aUksoeXFco92OBbuadBaFegkOwKA
	 /zc1NgnwYsjYTusndlb3pPIqUX0NLnp+UasjukR6lCG//wa2r4rnOWZQx87tqWkeab
	 POtQ60cbQizkPL6c8me1H2PHBL6f0hD3uy2ELSzvFt2388yhEjichjpnjMK0smbk9J
	 jAphIo/OgrAlQ==
From: Christian Brauner <brauner@kernel.org>
To: hirofumi@mail.parknet.co.jp, linux-kernel@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, Zizhi Wo <wozizhi@huaweicloud.com>
Cc: yangerkun@huawei.com, chengzhihao1@huawei.com
In-Reply-To: <20260629130943.3671939-1-wozizhi@huaweicloud.com>
References: <20260629130943.3671939-1-wozizhi@huaweicloud.com>
Subject: Re: [PATCH] fat: reject name longer than NAME_MAX in
 msdos_format_name()
Message-Id: <20260630-fordern-gebastelt-rosig-d8b3f12a11ee@brauner>
Date: Tue, 30 Jun 2026 13:01:13 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev-4217c
X-Developer-Signature: v=1; a=openpgp-sha256; l=898; i=brauner@kernel.org;
 h=from:subject:message-id; bh=otsWDoBxDw7OsOlA5XvX8DRKZ2AHTVTuphMVADKQBWw=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQ5L/zzy/N80D8P8Yd3QlOT2ziNONcazhL7IbLtr8nM4
 AnpYRt8OkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACYSfJSRYXJD0fS3+3c9P1cY
 GC64bWLB5onH5e6r8ek6KxzPtboiGcvI8Ogms3Kd5VxNgf1aOrFHut8mv2+bdKm6kmXa5bP/ZPy
 vcQMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

On Mon, 29 Jun 2026 21:09:43 +0800, Zizhi Wo wrote:
> fat: reject name longer than NAME_MAX in msdos_format_name()

Applied to the vfs-7.3.fat branch of the vfs/vfs.git tree.
Patches in the vfs-7.3.fat branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-7.3.fat

[1/1] fat: reject name longer than NAME_MAX in msdos_format_name()
      https://git.kernel.org/vfs/vfs/c/9d7ed813ee5f

