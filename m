Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE994F052F;
	Fri,  4 Sep 2026 15:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788534657; cv=none; b=YyvrNpW5w42OrM4RRVSF00XbVTWFqWYSzF8ce4gfUMpcsrp6LAJnPT07Rur32/MD2LeE9sHxcjHcpFGLO5tTm+mxgFQy3rAmUql3XUJsKXNWlpfx+iGPAsGQ0/2rTJEWWfucUe+gNT+Lr8c5L8FcAXHX2BvMWSXSobumVpzyjog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788534657; c=relaxed/simple;
	bh=A0VpHOoTUbM1tou3WIkcE6JwwQ0HC0j4IOAJoYAQEqM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sh5FVlcawiUrNAE+Egq3S+lbFlCygMOYj0pCfSn6DUSHHMeftI/EmC8zTPRWebRDax7LwOHNoYXxqNby/bWwY/dRujox2v/MhWEkLy5hJ3D0dT7K6jZbiNiMl9CQ0jofzI6fq4AMmI/wWWsstUbGOgTGZ6reg9DXcQ0oG+Zma5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VB3Gp389; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VB3Gp389"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id EAE621F00A3D;
	Fri,  4 Sep 2026 15:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788534655;
	bh=41xaUrJ1lAeNQeQ/qi/93VPU9j/VGLCqogvprDRRNhA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VB3Gp389hUiJzqvsLNBiOxo9AiBTn02To+KR9uXQbCTwnr1MfN9K/mfYWPpkTQYoi
	 YkSwXqdiH4MVDRmvZayz5DTTmd7tsTIJhqEsiBQ3VlBGcQBtX7Q6V0d1qqBAGbutA4
	 YBaPGJLRz8WvCU8m9I5oOD/6mQhQWDsfTzAs+Re6PhaN8sHtYH9UTWU8n/vsjGRzma
	 YwTvxKJ6eQC0djlK9jHVUYb/cXNutoS9zDShgIfepZ+JjJGdx9OMIEewirFY6jcTaF
	 yD2lEjdL0GwoSgI4JISCTQdxtXsBn9k9OJn4pclMED29mV+rIlc390GxVcXiR5xkzZ
	 F3nGaY5o8zg9Q==
Date: Fri, 4 Sep 2026 08:10:54 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Jan Kara <jack@suse.cz>, Jakub Kicinski <kuba@kernel.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Hisam Mehboob <hisamshar@gmail.com>,
	Martin =?utf-8?Q?Kepplinger-Novakovi=C4=87?= <martink@posteo.de>,
	Amir Goldstein <amir73il@gmail.com>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Eric Biggers <ebiggers@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	David Howells <dhowells@redhat.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Theodore Ts'o <tytso@mit.edu>,
	Catalin Iacob <iacobcatalin@gmail.com>,
	Stephen Hemminger <stephen@networkplumber.org>,
	Andrew Lunn <andrew@lunn.ch>,
	"Maciej W. Rozycki" <macro@orcam.me.uk>,
	Andrei Vagin <avagin@gmail.com>,
	Wei Yang <richard.weiyang@gmail.com>,
	Bhavik Sachdev <b.sachdev1904@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Wang Yan <wangyan01@kylinos.cn>,
	Bala-Vignesh-Reddy <reddybalavignesh9979@gmail.com>,
	Malaya Kumar Rout <malayarout91@gmail.com>,
	linux-doc@vger.kernel.org, linux-mips@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	Luis de Bethencourt <luisbg@kernel.org>,
	Salah Triki <salah.triki@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	"Tigran A. Aivazian" <aivazian.tigran@gmail.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] bfs: remove the filesystem
Message-ID: <20260904151054.GG6047@frogsfrogsfrogs>
References: <20260904082954.48738-1-enelsonmoore@gmail.com>
 <20260904-hinnimmt-triumphieren-handgefertigt-4e51fe2ed659@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260904-hinnimmt-triumphieren-handgefertigt-4e51fe2ed659@brauner>

On Fri, Sep 04, 2026 at 12:43:09PM +0200, Christian Brauner wrote:
> On Fri, 04 Sep 2026 01:29:19 -0700, Ethan Nelson-Moore wrote:
> > bfs: remove the filesystem
> 
> I agree.

At the moment, I don't.  Nowhere in this thread does anyone mention what
someone with a B(oot)FS filesystem image should do if they want to
extract whatever's stored in the filesystem.  Are there userspace tools
for that purpose (ala efs)?  Does "binwalk -e $bfs_image" suffice for
that purpose?  Or is there solid evidence that there isn't even a single
user (ala freevxfs) who strongly wants it to stay in?

I'm all for getting rid of old cruft but there still needs to be a
documented offramp for users.

--D

> ---
> 
> Applied to the vfs-7.4.bfs branch of the vfs/vfs.git tree.
> Patches in the vfs-7.4.bfs branch should appear in linux-next soon.
> 
> Please report any outstanding bugs that were missed during review in a
> new review to the original patch series allowing us to drop it.
> 
> It's encouraged to provide Acked-bys and Reviewed-bys even though the
> patch has now been applied. If possible patch trailers will be updated.
> 
> Note that commit hashes shown below are subject to change due to rebase,
> trailer updates or similar. If in doubt, please check the listed branch.
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
> branch: vfs-7.4.bfs
> 
> [1/1] bfs: remove the filesystem
>       https://git.kernel.org/vfs/vfs/c/e36781a626b2
> 
> 
