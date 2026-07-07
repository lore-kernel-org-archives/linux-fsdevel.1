Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADFC91A08AF
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Jul 2026 02:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783390720; cv=none; b=e1JA99vwYJNRebosc4Ouv3mtOVPbaajiJtv3wYg7H8qi7P4xa72m6SDL7eJ/vHg/126liSVqAgmcKuuWUnq7YP7BcUMLIFdSntZp0wSA7vvL7jX869or6kU8uvNmbPlKzIjanDdyljjPZKGQkcQ597qGvEhQ6+oxDItGeXv3W5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783390720; c=relaxed/simple;
	bh=42Fvff7hsvb3Kj+Mdwf0QHasrj8p6w6jVRl4YYuTcdE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hDQ9+JG9gzj9pbWneUzmEcBnZi7kTGGbOf0ViqficFmCTHLKv8guzAKwMw4vksqThWaozRz2/YKMKufWv2a6kE5QeVFn2eqFPKZ+I7L/deXuIIZ4xGKn/96k4t+WVkmEFQDziAEW6rOdHUtYopCktVDJjxZ/6vPED+Cjg6pKl6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l5eEQNMM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l5eEQNMM"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 5159F1F000E9;
	Tue,  7 Jul 2026 02:18:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783390719;
	bh=tXJ25YigGQ6BiRhlovD+fcvj/HAwYCu9k3Vi5vgRN/M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=l5eEQNMMc9oOZ3uEBsZjK4K7MFSRObwMmKBC4kbw+5cMWnrE2cozhpTaGxQlSodnL
	 izkZOuHfrpyHWVOJOBxm5M5t7Baq30F7pI5jgW/8P0duO5Ua/a1GwffV4Pj0abFIRu
	 XsT7/cichLVUwrbSEiZCfeKkODKvTMqRA1l8U40EyVgui3D8hAtnFPsDav8/0VlXcF
	 GnvyofbmQmQ9uyfOF0ZUjP6utUCZdkbbuqsy3hnzGnV4zTNM5IY4yr74ZfmSpY8Ihe
	 R/eUdgolMvWKZQfkxIjSfQ2UC+eZbP/rBaEDI2vbo+WOVBEzN3x5luCsgXISvvEvlJ
	 GJQium+g+9fvQ==
Date: Mon, 6 Jul 2026 19:18:38 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH 1/2] fs: refuse O_TMPFILE creation with an unmapped fsuid
 or fsgid
Message-ID: <20260707021838.GB9368@frogsfrogsfrogs>
References: <20260615-work-idmapped-tmpfile-v1-0-754a94d81f83@kernel.org>
 <20260615-work-idmapped-tmpfile-v1-1-754a94d81f83@kernel.org>
 <akju9Nag-jhIoVq9@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <akju9Nag-jhIoVq9@infradead.org>

On Sat, Jul 04, 2026 at 04:31:00AM -0700, Christoph Hellwig wrote:
> This commit causes failures in xfstests generic/633 generic/696 and
> generic/697 with messages like:
> 
> utils.c: 948: openat_tmpfile_supported - Value too large for defined data type - failure: create

Seconded, I also see these test regressions now.

--D
