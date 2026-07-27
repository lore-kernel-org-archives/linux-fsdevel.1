Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB2E5302753;
	Mon, 27 Jul 2026 14:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785162056; cv=none; b=NjRB5i/rkZ0q8VmoIiHs/TzzNiMV8eknP1rAR82fpBYDeT8/4Du27c79VeSZL4OrmuDQo5an2zLnxbyIZ5kI5lhXx8IYyh9d+tRu5j55MuuzMGVTmCcWKw0Jd6vFctKDVokBMedqWNEhus3Snnb1mlgZZxUR7i8OYY4maHvbSiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785162056; c=relaxed/simple;
	bh=CqexEcVik9y58u75SCVQW6EfJzVAFORsUGZWc+tnaZE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=W3y9PeZoiqeRdMfMJj5v9/aDiOUN0f+JyxgiLYyO2pMGtUC0OaXMrcIQoj/1/a8bU9z2r+/uVu2eRt6TnPEHrHr+dmw8liwDaFeLgJ0164OjSb8RSKfJJrApLwUWqMDqyRoJj6BGtg5PAzAzbKT6wbL0IZqAN09OdbBsEOV/H/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ot4TN86L; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ot4TN86L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FBF01F00A3A;
	Mon, 27 Jul 2026 14:20:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785162055;
	bh=h6n7h7Pt4+PAijzzP9Ra+mAILFk4zrL7usPOeI/wvas=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=Ot4TN86LIt5i4R2IAw0dCJPaIxKPgpqfDDhQlQviup9PdBI211DXxqqoWh6vTB+oF
	 qAXiLjHJts+3fzepbsBIbj7dF3x30KP4G9UFhAUodtmTuPyHRwhpUwx9FRB7IOA7//
	 aheTIRKwqa/9M7Em/pIWM17/ts8jDCddSrrfObKKdeGxaGNb6xVybeNYvcxRpwFEFc
	 +OvuvRW/wpMxsTMOsF5xq4yFf0DY9jX88IPS+x2HBAzCW5U5mLUBL5y+Nj0EA8ziwj
	 KOlfn7iKdyGeSSwRAXacQ4WU4uOqfKztA4OvrROz7rhvAV3FokjX4RRzQcYKOX6KeS
	 eaSA4lFgtsXuA==
From: Christian Brauner <brauner@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: viro@zeniv.linux.org.uk, jack@suse.cz, linux-kernel@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org
In-Reply-To: <20260724171422.429284-1-mjguzik@gmail.com>
References: <20260724171422.429284-1-mjguzik@gmail.com>
Subject: Re: [PATCH 0/2] lockref tidy ups + touch ups to it's usage by
 dcache
Message-Id: <20260727-gebilde-filter-auszahlen-c549401f6d4b@brauner>
Date: Mon, 27 Jul 2026 16:20:41 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev-09492
X-Developer-Signature: v=1; a=openpgp-sha256; l=1325; i=brauner@kernel.org;
 h=from:subject:message-id; bh=CqexEcVik9y58u75SCVQW6EfJzVAFORsUGZWc+tnaZE=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSlZ7pyXOnbfPt8Fp+1r57ja93Xerc4SjNvchm2fs97O
 p8h272so5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgFYCJXUxkZnsYbzLcXS7Mvmnnv
 2tps2zRr23dPBJLnvWr+Po3JX9mBmeGvSG3MSvl3/P7x26wFfS6edt2dyr6j10igbMqOI9rScyw
 5AQ==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

On Fri, 24 Jul 2026 19:14:20 +0200, Mateusz Guzik wrote:
> lockref tidy ups + touch ups to it's usage by dcache
> 
> The open-coded check for < 0 indicating a dead object uses information
> it should not know, so to speak.
> 
> This is a preliminary clean up for a longer term goal of moving dcache
> away from lockref into an approach which can atomic_add both ways
> instead of suffering the cmpxchg loop.
> 
> [...]

Nice cleanup!

---

Applied to the vfs-7.3.misc branch of the vfs/vfs.git tree.
Patches in the vfs-7.3.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-7.3.misc

[1/2] lockref: tidy up dead count handling
      https://git.kernel.org/vfs/vfs/c/21a8e8068278
[2/2] dcache: use lockref routines for dead count checks
      https://git.kernel.org/vfs/vfs/c/4f87acca1a2e

