Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 059533D88F5
	for <linux-fsdevel@vger.kernel.org>; Tue, 21 Apr 2026 14:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776781819; cv=none; b=kjk3up/gSXR80K3p7+uVbXvyYuf1ToilzauV1EmMIBYg8gwYwRkMhZyPX1VOEcZPw7dyisAU9F+CddlBtVC3jhN3VoZoP5Ktl5Ha6xLZG3JMHy6uCFDm8hPe1PyRcsn/73nOFVEwhlGDSjhZXpz/znkvrVXIvPc/gl5T/dRi2Vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776781819; c=relaxed/simple;
	bh=OOpDos/Z9VaSP4OAHAzHjn2FVBZGB3TMPAJ8x0XR0vE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=unAu8grm4aQU3yrVBpFPdUIJRTMFBvue87/TbACYCJRWZgVCLoVqeCRcv/fofylLH5a3eRTBtJc6yIfSKjkh4oeb1qTa9ohSsfv4kdbmujZbkGuhyQJCBQdXgyxo3jR+ZZCz40MYYb19pUNxg7+odweaBVxUce7/qLy0eFa820c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=HNkNC2gI; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="HNkNC2gI"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-8eae9229110so339332685a.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Apr 2026 07:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1776781817; x=1777386617; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=J5FC0V63oKQuJOmL33I9jXWd+zejUzRlce9wtAa95Fk=;
        b=HNkNC2gI2eee0tIfC7zlTHK7o7liYfOU+2qWrUmMuIJhiv808HBeCaTB00/dh1kfEc
         75GibcrGetQgVIcD/DGPJ5RtqR91E6MZzRcOezTyV8FtTqc+B4JVXIR4lRsy7Th0UfNH
         Oh5TpA0f+5JkuzRqs+QQFPEZNImMjLBkW1q9CXsKQpyEuUvrhLCGEpKGttnFqofxB5QU
         v/NyiNdDAsnNozXE3Ite2steK0jDTBwuQznep6tHX9RyEtIt3y8xmyJDJLHiqvX5/JqR
         VvVU30LAv80bt/gsCSp2zvZvBBidUjYNGQ7UbuwNksfaX0QiGtjg0GoYL0xq9y6VYwl5
         8v1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776781817; x=1777386617;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J5FC0V63oKQuJOmL33I9jXWd+zejUzRlce9wtAa95Fk=;
        b=Y5u/DX7px7KFgsqYhTahgKx1YeE//15RFYsJ3PG+DCI1hpT94brJVmd1wzbeWhYOAD
         BUm4AaE1jqAhfep5wx/7OEzxAv6fSadrrlXRuwrXSLbyxmm8WsBD2cQk396WC2HCeRvG
         sVFLEGVPcjE0tTnnm3z+hkfOrYV0nwaLaVy4WJb6g2hXwKiPJ6BOfv9lUn1jnrg2daia
         2M2Py+ozF5QZolpAzhwPj8K/VNmEmc34wO8IC+HQnnnMNnMWc2sfGFzq7NCA9G47MWjA
         ysSBHCAkSn5J2NlRtSYuVXfo/eIJ+bxeQir5686JWvP8CBrVCKKVHDVHlt0qr9G6/nFF
         vmHA==
X-Forwarded-Encrypted: i=1; AFNElJ/E1osiZ4zyr8YsAVegLvN2QDuruJuDjqUJbGFtDvbSJfdnCGS+zeAmf83qQ9lUN5nXC02TITP2LrDODGQh@vger.kernel.org
X-Gm-Message-State: AOJu0YwRn3liuqs5HqQdTFQg4NWqq0tyWRa7MdsjPuMAl4xg27/jzOY4
	Lc/ozmQTPD17AJW0xQ13STMYw0U1dzgRzZTG/gpcRQtoVkHiPdQxaNyE5NOkYc2wHdE=
X-Gm-Gg: AeBDieuZhjodn+xBiUcA4VCvsQTVF5Ojrj/f+nu2MYJyvvyrP4vt28r3myL/nVWB4SO
	S77R9LnYHfFWjRsLh4Llp4RnDqRB2DNQioo0j4GrrWFg/gF6y00czbM6W/luF6z87ea2LpqmwzN
	0bfCvn9otXqKu9J9U7rEEz15RC5xBqdcpiKWmqPtwR/QcCPJOTLNW+zi+VYBCNXXtnOkCJF0Vba
	aR7E7hrSXJIqWpH3zSiuceNe4xSwq0OiXNT8bwfjxJQtxsJm9B6M/bi4QhQzI++yN7BtE7f5lAs
	ybOtIaEZgTaywbh0zWFM60AdS5oj3Ru+gwGyUg4CUHICZ9Cknx2dtBk0rjPrfikLpbleYpNHdRV
	XRew1zXhdBfDyfODKMqEuwV3zIvvejRo2jbMbS75/FPQ0ldJGiyOPwXvtlNJx9L3vniQpITVUzX
	EehcBWyM6YtaVOHOp8i1RRMVgkbQFfH4Gk03B0UM8rE+UaF+0=
X-Received: by 2002:a05:620a:17a3:b0:8ee:e011:a77a with SMTP id af79cd13be357-8eee011add0mr229077285a.13.1776781814650;
        Tue, 21 Apr 2026 07:30:14 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F ([2607:fb90:a81f:533:271b:a845:9f29:eff0])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8eb19632130sm612607285a.41.2026.04.21.07.30.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 07:30:14 -0700 (PDT)
Date: Tue, 21 Apr 2026 10:30:08 -0400
From: Gregory Price <gourry@gourry.net>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: John Groves <John@groves.net>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Bernd Schubert <bernd@bsbernd.com>,
	John Groves <john@jagalactic.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Bernd Schubert <bschubert@ddn.com>,
	Alison Schofield <alison.schofield@intel.com>,
	John Groves <jgroves@micron.com>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Jeff Layton <jlayton@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Stefan Hajnoczi <shajnocz@redhat.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Chen Linxuan <chenlinxuan@uniontech.com>,
	James Morse <james.morse@arm.com>, Fuad Tabba <tabba@google.com>,
	Sean Christopherson <seanjc@google.com>,
	Shivank Garg <shivankg@amd.com>,
	Ackerley Tng <ackerleytng@google.com>,
	Aravind Ramesh <arramesh@micron.com>,
	Ajay Joshi <ajayjoshi@micron.com>,
	"venkataravis@micron.com" <venkataravis@micron.com>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	djbw@kernel.org
Subject: Re: [PATCH V10 00/10] famfs: port into fuse
Message-ID: <aeeJ8Lgg2z0X-NC_@gourry-fedora-PF4VCD3F>
References: <adlBcwJjLOQDAR65@groves.net>
 <CAJnrk1a06zkUmXW5EFiUmgAoFauwtzsYvnotaPH0ifVtyh7iDQ@mail.gmail.com>
 <CAJfpegvVTcV89=q3L326aGQjhduBcv7PVg5QKftGLjNZmCLmaw@mail.gmail.com>
 <ad4_jFsR951c2Mtn@groves.net>
 <20260414185740.GA604658@frogsfrogsfrogs>
 <ad69tTnx5YkD4Y9K@gourry-fedora-PF4VCD3F>
 <f254f6fc-dc06-4612-82d7-35bb10dbd32e@kernel.org>
 <aeUU8hMwPij2WvfF@groves.net>
 <aeVy2MzucnrLlOQx@gourry-fedora-PF4VCD3F>
 <CAJnrk1ZpPS9rOoBqOBRsqTu0Zgk=aoYzpYZ0mAVDCoeewtLhcg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJnrk1ZpPS9rOoBqOBRsqTu0Zgk=aoYzpYZ0mAVDCoeewtLhcg@mail.gmail.com>

On Mon, Apr 20, 2026 at 08:12:17PM -0700, Joanne Koong wrote:
> On Sun, Apr 19, 2026 at 5:27 PM Gregory Price <gourry@gourry.net> wrote:
> >
> >   struct fuse_dax_fmap_ops {
> >       char name[FUSE_DAX_FMAP_OPS_NAME_LEN];   // 16 bytes
> >       int (*dax_fmap_parse)(struct fuse_dax_fmap_parse_ctx *ctx);
> 
> Just a note for later, if the bpf approach gets pursued further:
> instead of making this a dax specific ops, I think this needs to be
> integrated interface-wise with Darrick's fuse-iomap work since he does
> the same thing. I think dax_fmap_parse() could be renamed to something
> like iomap_setup(), where userspace can use this to do any sort of
> generic setup, whether that's mapping related or dax related or not.
> In my mind, the dax vs non dax distinction is handled by the fuse
> iomap plumbing that chooses which iomap entry points to call,  but
> beyond that,  the callbacks and struct ops themselves should be
> generic enough to be shared between the two.
> 

I think this is reasonable.  I'm not a FUSE wizard either, but I would
presume the iomap_setup() process would just essentially be John's
existing GET_FMAP / GET_DAXDEV code bundled.

GET_DAXDEV happens lazily to save him the round-trips to userland if the
DAXDEVs have already been seen previously.  I think your proposal does
in fact save him further round trips, and it would probably solve the
performance impact he saw from porting to FUSE.

> > And otherwise, imap_begin() works exactly as Joanne proposed, but with
> > in-kernel cached data instead of the bpfmap.
> >
> >   const struct dax_simple_meta *meta = (const struct dax_simple_meta *)
> >                    bpf_fuse_dax_resolve_get_meta(ctx, 0, sizeof(*meta));
> 
> another note for later, if the benchmarks prove promising and after
> the LSF discussions we decide to go with this approach: imo we
> could/should repurpose this into a generic
> bpf_fuse_iomap_get_inode_meta() that returns a bounded pointer into
> whatever opaque blob was cached on the inode during iomap_setup(),
> where it'd be a generic kfunc serving both the dax and non-dax case
> for any kind of mapping layout
> 

Note that Christian Brauner just said he preferred not having dedicated
bpf storage in struct inode [1].

sans BPF, is there value in such a metadata blob existing?

If there was a generic format, then I suppose the blob storage would not
be BPF specific, it would just overload it (simple union).

[1] https://lore.kernel.org/linux-fsdevel/20260421-arsch-gelernt-e0b5bcd8a7ff@brauner/T/#m8fea90f5ed4a1b23bdc2563d978948b263b2030b

~Gregory
