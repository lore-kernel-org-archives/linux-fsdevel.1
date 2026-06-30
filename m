Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F3A379EF7;
	Tue, 30 Jun 2026 19:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782846439; cv=none; b=FzYo87/SDQMnPS4Is/jJg+k2P7/jdTD1pulF3STJDr+iyCZHqN8ddNYmneOixP1m/14qfAuRZPov+8UOFaj405qWW+gRCVNddZiOPVTlPRfEhBngsTHkxckITXcRDJAdYdWLNu0LMlnJcPN34QnZLq8NPT7FFMOWp4SpFvXAYkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782846439; c=relaxed/simple;
	bh=Nf2PerGNmpvqKBBZFz3dgb+aLZyeI7IiblD+n63hqKA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZEvH6PWjkCMhlJKopAjMvN2wQCtzLmnDY49XrQr3Sp1olkSRHwCRNNJ02x83p1IzNc6Lx5GHemQYcST8wVBqnAgzfAcRAIPVpNHxmp/3M0NRmwrEjfv1NPREEW4yVnGeS/f2p87IupZy/VLAy1KgUbF9WTwF4GBeu2Z5mXVDLIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=aUagBS41; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aUagBS41"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=WgB1yffYfNl1d6ertecsZ4ql1VDBY3O455vaUMG9kNw=; b=aUagBS412TD6HJktcSRg0Wms9N
	/ghAUcW+e5l5gmPcUTvSKU+xFAvfkl4Lneckv78Nw5T4lz70Bn5NQVSmJ7KwcSI90Is9/aoXEsD+b
	Whe2fkzz9gNleY4w9rr3ThBBM15aahfiEnkgGFPcM9e+fm+SPb4cUC46IOULMcXHiS81SDcNFOp1L
	vge5f6oh5OXZnCKqA5wvu4JU9x3yLW9w8JDfcEH1EtOPV95wvtGsJ7RJ1VDWpgCXGFKacIE3eXOEf
	8ybOa90zX9mt61V7CsFAtD74Sf8pXToD36A9sOaFL4z53MCoTtbGj7VHqhxCYVGgftvA2SwxyuKLb
	cIZ8/4Pg==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wednd-00000005PXP-00Z1;
	Tue, 30 Jun 2026 19:07:13 +0000
Date: Tue, 30 Jun 2026 20:07:12 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Zi Yan <ziy@nvidia.com>
Cc: Gregg Leventhal <gleventhal@janestreet.com>,
	"To: Alexander Viro" <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	"Cc: Jan Kara" <jack@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	Song Liu <song@kernel.org>, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Eric Hagberg <ehagberg@janestreet.com>
Subject: Re: Subject: [BUG/RFC] write-open file THP cache purge can discard
 dirty page cache
Message-ID: <akQT4G4RpxPPMb2Q@casper.infradead.org>
References: <CAFN_u7H_0ECF3jixP=T=U7AH5=Q3wQNvJMo8an3VqUDMerQfUw@mail.gmail.com>
 <akQMy54dxVTVkMJ6@casper.infradead.org>
 <DJMM9V4Z58QP.2DXAKKZ4YE6HA@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DJMM9V4Z58QP.2DXAKKZ4YE6HA@nvidia.com>

On Tue, Jun 30, 2026 at 03:05:16PM -0400, Zi Yan wrote:
> On Tue Jun 30, 2026 at 2:36 PM EDT, Matthew Wilcox wrote:
> > On Tue, Jun 30, 2026 at 01:01:53PM -0400, Gregg Leventhal wrote:
> >> On an affected 6.12 kernel with CONFIG_READ_ONLY_THP_FOR_FS=y, a file can
> >> contain read-only file THPs installed by khugepaged / MADV_COLLAPSE. When that
> >> same file is later opened for write, do_dentry_open() notices
> >> filemap_nr_thps() and drops the page cache:
> > [...]
> >> 
> >> This is unsafe if the mapping also contains dirty folios.
> >
> > But there shouldn't be any.  It should not be possible to have
> > dirty folios and THPs in the same file unless the filesystem
> > supports large folios natively.
> >
> > If the file is open for writing, the attempt to create THPs should fail.
> 
> Maybe he means order-0 dirty folios?

Even then.  They're all supposed to be gone.  I don't want to guarantee
that the filesystem will properly skip over clean folios during
writeback.
