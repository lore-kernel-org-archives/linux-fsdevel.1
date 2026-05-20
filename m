Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4539434753B;
	Wed, 20 May 2026 20:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779307298; cv=none; b=onPbgkLandrltccCHgABOWQ9Tu+VhbY9yP3FtW3Cb5RPNO61tFsHTRlVNrT3TVgPcbVpKsFXR+sPJRmX/ZH5oudOD+G4VYaocfSMOOvtTwh0AvAO3ANLivINc0Pj5IZ78tjtEF+q0hq+tyvP8L+d+7oJPYg8P2epWMRB9zUtgDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779307298; c=relaxed/simple;
	bh=lnTTto9b95RAfXXRj4UiwuMSpSCWZc8w/JjRRQrNMCQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fBct1+xbgZ8ylSFzC1UlH/fOZCFDUpcbtNIMD5HG/Rq0oyuYdCQAyMEgXhq31vAAEG0zq7a0wLa0Xnr7xq33UQUAf5tkVMWBAiZSoVLJ75QQx8xJ2i90O7cjnQ65Jg+vFjb2roqWvJ7vkwKBzxbxJXV+R/gGzCiikpxlymSIDBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cV4UAzh3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cV4UAzh3"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id C68EB1F000E9;
	Wed, 20 May 2026 20:01:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779307296;
	bh=rqBtiSF3LveVOrhxuPy3DxyEPbf3FnzHm4Qi4Adenxk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cV4UAzh34o4sncm+ieeXolmOnL89aAr7T6nepDD+zPsiufsGUHyJlOje0Ohugrb2t
	 6yWcg+KRBczM0BNP8lUr+hLP+SkOYs/joRKeOZrweFlHwg1zSw/tlC9cK+BElq/sLs
	 WebkTjEOvqFHOpbN5xPNvYt9xk6zQJyi2Xc92qt+MUjH5Xv88UCYC7CCEcgEiY0v20
	 smMGFDLUpiZn4aMb0y2rmRe/MnmUJVfK9xbqU/T/4olg7U+NYuXSeQSASQyqFFnnGC
	 iGWOgGhwSQzwr107UF4q1GodjpMVkm98yL5AroAC9cwkpvq1YARqcqyRFHze3WzAgy
	 cs3spSCgrk+Pw==
Date: Wed, 20 May 2026 13:01:36 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, neal@gompa.dev,
	bernd@bsbernd.com, joannelkoong@gmail.com,
	fuse-devel@lists.linux.dev
Subject: Re: [PATCH 2/4] fuse: store backing id in fuse_backing objects
Message-ID: <20260520200136.GM9568@frogsfrogsfrogs>
References: <177922944800.2436629.7011047808676668088.stgit@frogsfrogsfrogs>
 <177922944866.2436629.1081840703046716342.stgit@frogsfrogsfrogs>
 <CAOQ4uxgnJbbTBup7UDh4R0AStx5hL0DYY09Fk7g9ETJehopMmA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxgnJbbTBup7UDh4R0AStx5hL0DYY09Fk7g9ETJehopMmA@mail.gmail.com>

On Wed, May 20, 2026 at 09:55:24PM +0200, Amir Goldstein wrote:
> On Wed, May 20, 2026 at 12:28 AM Darrick J. Wong <djwong@kernel.org> wrote:
> >
> > From: Darrick J. Wong <djwong@kernel.org>
> >
> > Make fuse_backing objects know their own id, it'll make tracing and
> > recovery of backing ids easier later on.
> 
> The problem is that in the context of fuse passthrough
> backing_id is just a temporary integer name of a fuse_backing object,
> but fuse_backing may outlive its backing_id (e.g. in fuse_inode_backing()
> and in extreme recycle situation a backing_id can be reassigned a new
> fuse_backing while the old fuse_backing object is still alive.
> 
> This only makes sense if backing devs ids are never closed, so maybe
> only if FUSE_IOMAP and FUSE_PASSTHROUGH are mutually
> exclusive (did we do that??) and FUSE_IOMAP never closes backing ids.

In iomap they're *nearly* uncloseable because we have no idea how many
iomaps might be floating around (either in response to a
FUSE_IOMAP_BEGIN; or in the mapping cache) the system.

However, if you can knock the number of iomap inodes down to zero, then
you can close them.

<shrug> The self-contained id could be set to 0 on idr_free, so at least
you'd see in the trace data that you were using an un-indexed
fuse_backing.

--D
