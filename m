Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B1A30EF84
	for <linux-fsdevel@vger.kernel.org>; Fri, 17 Apr 2026 13:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776432632; cv=none; b=KapBeAB4bNj8ehyTSWKuVpIP2db7y39xQ86fOW1utd/udnBdqL+CR9ooz0GEL0A6ULWiqI4WonnzIN2N0lQywtVSZ0DT0on7M46VZFm5S8P5gFUPe+y4rxjnA5ppuhVwDL5dw+9vALm/vf9u+nTObo7w5mXqb9aSzjB3a7+ouvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776432632; c=relaxed/simple;
	bh=hkpNLJ3ybawOIa1fkGOwYhoNiDG571CgTvN9uVT7u+s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vEA2VXvM9/TwbbwbI3FqYPu6PcrDQ9DYnEpl8gj+ykyvudmZuoIKZ/FzRNGQuSOkDdbONB7ZhO6ddoIkJb3lOY//1XcQ8c5UHp/GdJXO4yXSWPTREQUPoiM9ilH7cdJ2YBSZQuJ2Ym+zQqPCpmrlal+SEB2H5m9mw0vxUnXrnjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=fwqU9rc9; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="fwqU9rc9"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-505a1789a27so3368201cf.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Apr 2026 06:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1776432629; x=1777037429; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xgTqv4J4Fl9HXQyBvnfY8cYHtSEuC0puU/+LlJmiu7o=;
        b=fwqU9rc95o1LTxXbeM3xVzr/YEF6qQLLwnIhwMCPZzaaEAl6BjYzd9K4SMG+IkvcuM
         6mF3iufDqSliJDpuDd/qFSvj6sge9Bl6ut1WQEhwxX0NgfPVSWBt/NIEhoSvE9LQky4a
         ziPucVpAOTXZqRs1IfU6TcWSLjQa1gWhvYBhb+gLbuOTkswwRsbepenvXxOBM0cVOhdU
         kJ8LZl5X0d7GiOhsaUPmwijnaf6SX7xQfBrOoXP+sYNxndqV9EygIoLTQephxZOm6Me6
         iEJgTv8oYwCldLJ0rlD116HeN2ahjql2pDnql+FNBAYlDIyU7quduG/rVTPQVc1ZAxVX
         WNEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776432629; x=1777037429;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xgTqv4J4Fl9HXQyBvnfY8cYHtSEuC0puU/+LlJmiu7o=;
        b=Fw0QV5j2m9erpZRAkOjQacVyFex840c3Dh16Fgacq0Doas7y0nIPT1/AJb21M2vMwF
         DYU4Leu0X46KVbdJYJG+BUKdmxBLko044xeFX6GSYOA49MphRyzvLu8Av8hejzaAhde6
         g24ZWxVHsEG8M7UdF7FSA56LyRbrholwMODDPdvW3f67wDMBNO+Y0FgzYNgybY2VHI5a
         /R5Cv5Q18ihf8c44H8dIfX9ESxH4FJLb+jphDRAVkkJ4XGb5/7VqCUfQCj3uJatjYIyA
         RKz70bJc++blvmpcaVTmYc5t1WVzIimfkab6/1vkG3TREArjKEOcd73AtnndwFJQgrzk
         FJwQ==
X-Forwarded-Encrypted: i=1; AFNElJ8XBh3FoKqiCREXLCp8My6aHO/21MxOtE8JIOGcAduhxF8mivc9jnT4vOOvHGGvcQygV4ohWuGyE2xosUKy@vger.kernel.org
X-Gm-Message-State: AOJu0Yz09g+3YPBJfQL+gxM22976ku15ccUej04F3MGJvzSO/gOl4UJA
	yjizERynTViwF4ypzswJ1DyLTwYfNJ/BcGYVD5AI0itNac8BHI5Ofq+3g2rhkYoIJ+4=
X-Gm-Gg: AeBDieuJQTpznGEQJt8xCyGA4KYeSHtAAwRtA1f095Nbxr59Zg0qieVWQbQCsmXe+RE
	dn9I3D3mNjli19rK3hT1yNxX4eZaJh5NzIUnSwsiyZfgWSjCvz6P1dmEXZAJ2C7kWzXApl5rCCw
	ZxlPPu8OxDjRnGGz5u+3MpEwJeANFq4yf+xK3r0in6+YQg1FS2LGN/J+J9QvZVyhLCAx9ppYoCs
	WblB2PJhJde6o87WSliZ+a04wwe2x+Ywy3D3J7sf8kb1BZT2VgYkVxcRONMVSieySyuRMxzXl/n
	OEHob6EsbDfKKgpt8ErfvS6rMitYMSe5SYO2Q7bqheVU2GRb8haWJPFKKiuZOPDvsUM+1dwvE4M
	pYCM5YwPbpFRpQDVpjCSm4iHaaGEoSOBHQZ346sB8aEwYv7yohoVyDc9Z+1IBYEvVBabopWerfW
	0irnRuAf0rvPF+4YgEo8XnS2tymyRBkIlIxchdta1XpOrdDAwsNT3npNqgp1ritQCZ+4csTLaEd
	QS6VftSLxByGnwltkZV
X-Received: by 2002:a05:622a:1f17:b0:50d:80ee:3962 with SMTP id d75a77b69052e-50e3683091dmr40533621cf.17.1776432629479;
        Fri, 17 Apr 2026 06:30:29 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-108-18-109-80.washdc.ftas.verizon.net. [108.18.109.80])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50e3bf260fbsm9752291cf.10.2026.04.17.06.30.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 06:30:28 -0700 (PDT)
Date: Fri, 17 Apr 2026 09:30:25 -0400
From: Gregory Price <gourry@gourry.net>
To: Christoph Hellwig <hch@infradead.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>, Dan Williams <djbw@kernel.org>,
	Joanne Koong <joannelkoong@gmail.com>,
	John Groves <John@groves.net>, Miklos Szeredi <miklos@szeredi.hu>,
	Bernd Schubert <bernd@bsbernd.com>,
	John Groves <john@jagalactic.com>,
	Dan J Williams <dan.j.williams@intel.com>,
	Bernd Schubert <bschubert@ddn.com>,
	Alison Schofield <alison.schofield@intel.com>,
	John Groves <jgroves@micron.com>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	David Hildenbrand <david@kernel.org>,
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
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH V10 00/10] famfs: port into fuse
Message-ID: <aeI18Q2lcxZLw-1V@gourry-fedora-PF4VCD3F>
References: <CAJfpegvVTcV89=q3L326aGQjhduBcv7PVg5QKftGLjNZmCLmaw@mail.gmail.com>
 <ad4_jFsR951c2Mtn@groves.net>
 <20260414185740.GA604658@frogsfrogsfrogs>
 <CAJnrk1ZgcMuwfMpT1fXvUwBBiq9eWFHWVeOFQFFKiamGGe1RJg@mail.gmail.com>
 <ad7Tps4tkNbndd9Z@groves.net>
 <CAJnrk1ZWVsKW2dhAWdBkCQskoTE+hmOhPFDhyz4EtExn=GdXGA@mail.gmail.com>
 <aeFDCeqZDPI3rm3s@gourry-fedora-PF4VCD3F>
 <43d36427-4629-4712-a262-391e64006eb5@app.fastmail.com>
 <20260416224331.GD114184@frogsfrogsfrogs>
 <aeHrsIGagdmZJ1Fw@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aeHrsIGagdmZJ1Fw@infradead.org>

On Fri, Apr 17, 2026 at 01:13:36AM -0700, Christoph Hellwig wrote:
> On Thu, Apr 16, 2026 at 03:43:31PM -0700, Darrick J. Wong wrote:
> 
> > ...however the strongest case (IMO) would be if (having merged famfs) we
> > then merge fuse-iomap after famfs.  Then we extend the existing
> > fuse-iomap-bpf prototype to allow per-mount and per-inode iomap bpf ops.
> > That enables us to analyze thoroughly the performance characteristics of:
> 
> Don't go there.  I think that you two are comining up with two
> interfaces for roughly the same thing is a pretty clear indicator
> that this needs to be fully hashed out as a single interface first,
> and any kind of preliminary merging is just going to create problems.
>

We're not sure how deep this rathole goes, and John's work has been
in the rathole for a few years now.  Hence the desire to hedge.

But it's obvious no decisions will be made before LSFMM - so we can
take a breath and chew on it. Maybe we'll get there in person.

~Gregory
