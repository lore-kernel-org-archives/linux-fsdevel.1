Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B0E3DF004
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 Apr 2026 15:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776267181; cv=none; b=c7EavL7NKZKZKbvMqo715q7ukmJvJqfX8f1agxZ7T3SB3+bCXLSh306lqdj8cHl0Sr/mJpsWuvtAdx+C4mhBz4TWrdg8nwVPu+di1S/EPMvh0POsyeMjv1+kD099Mj94q5RBcQc2v160bjP1tlVpXnXp1DM/VgVErLNmnim11qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776267181; c=relaxed/simple;
	bh=S9dcy47a6bd3TjyPD9yCkf196y5TA2ypeoVg+NZ5el8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GAeNFooEP/wF41JuM3CsooGAo8HpFAM65MFKqKoDUGlIuzr4S8D2JoEtYdxenPjvBjuuL1ny5birTVjgamXXrgvzhWblVvA4H5ZOCKPKPXAABmPeULgIdYWuVH4NBXJMuH50SYj3c56HnScq3o9cC7WrjRo46y8VZxry0MGdp5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=F75dbddm; arc=none smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="F75dbddm"
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-650789b22e3so7989882d50.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Apr 2026 08:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1776267172; x=1776871972; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=e5e7YwNWCtbTE/x5+I5oKOHLYRavpYy019TGcszzWak=;
        b=F75dbddmtN8OwVFOGaZDhKK+Hwp3WWuk6vEYx4MlQTcEs+tFqsdTq57ybk+HLuWF8C
         C6OwnvIApNdSIYMiehBPnT/3ZTurGwkLIlxJk5YEIH/y+CwjQosV+dZxCz34E3TusL6E
         ERtST/ZlnXo/FJuJl5pSsxQ9GTH7qD3pCxch5xREEZmaNYLAdzuNYZ4dlbYGwsW/z2my
         nxVyyA+LsvpSaiR+V237jdWKTs1RO2UQhEbpfvOjBVm0pyDcqOsQl2mp+0zzHKVH+itc
         ONzHa2xlsJiGmYeqHns8wheZq+qgV1xvolB4hGFbwGTmRtLNIMGjrGFyvOQP5Oi+vMRY
         laZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776267172; x=1776871972;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e5e7YwNWCtbTE/x5+I5oKOHLYRavpYy019TGcszzWak=;
        b=V18zNp9N4ZLG7ywCwZxbWNQOPx/cxxrae2iYPsWPviU84v4iXHQOutwNIfrS5UDDtF
         0VXYX9YJCO0m61217O1Xnk4tzzLENYuAerlr+SDHDYVYJX3dB1VrqGb2obvLOvzk1QMi
         sc9DT+7u8e5r8pE4gVEN6kwOXA07BZ6sCxphkUD3Tro+qvs3n+Yv4Ao/uUnJVahD4NGt
         aN8TXZoDrDbXrHXTsYpkrP5cjiIQbLrCkypIEFtxvXzcUuZWG4uf9d2iMqsYxoaiRQmh
         ofzbcdT4WTji2T/9fF72WXnEZymqOMCOpA/Fkc/2+SM2EgV922Ml/IMCA8aec7kbim9R
         Pckw==
X-Forwarded-Encrypted: i=1; AFNElJ/VQoA811Ugf5I+aVKqse/cO1+ZSUAhqgRFTTJriC4m3KkOgvsbYDZpbv4kLJpACRJFlxX2PpvFRq1DMj1r@vger.kernel.org
X-Gm-Message-State: AOJu0YzVEURrXiXu/brMlRXtiOUU1nMxIdXcIbgzwKZH3epyiF4GhEKA
	o/EbXjZfpMKUr4opfV2EJPslrpaZp+azjqZfih1G83VpTMBBl8Q3MaJ2U/M3PDvkpD0=
X-Gm-Gg: AeBDieuKAVTx2lQHksIHoQUnGUJGcvFE+49uWvencosI+QQt30aB+CYCLp/YF7colXC
	jAi+QpA1J3avT4mW9e/qx6+mANGULZtnsyx0rAt6LJd2R04G0+PQcIcoVQ1972Az8x1AmZI7UEL
	yeE+5UbWt5Jl3yXzTCbUS11ujQGxhZy8kW+KTbnm8OD0Wh3myao1rRieEJ49gMkgnogym5H3mJk
	WXx+ugyioOhdeKRwCRwc1aZQj+lsZlfU8c9wTlB+4wcwTN0nywct694enm5Oez9TAmIqs9eSVbC
	JtW70MLrURU0kxfxchPpab8F277Qdk6CM1GtfNcqXHpWLCnsQjAEn/mbYawu+TNZBfM637uoAtS
	iBR18XlgC7RKbdq5iv0L0Hh74vN1Al7S1+C/x7SPvK6m8mE5Dna8JroYDUWA6k7ViM1/1f3p4zU
	DqUMUHhSE9csVwP7vdQeXmPUUOOE/EVrdj1G0UFYnyrCme9JIo
X-Received: by 2002:a05:690e:4188:b0:651:c024:5726 with SMTP id 956f58d0204a3-651c0245898mr12329101d50.33.1776267171618;
        Wed, 15 Apr 2026 08:32:51 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F ([2607:fb90:ea03:4042:f7e3:e9e9:9e22:5a8e])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ae6cb9ea1csm16952326d6.28.2026.04.15.08.32.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 08:32:50 -0700 (PDT)
Date: Wed, 15 Apr 2026 11:32:46 -0400
From: Gregory Price <gourry@gourry.net>
To: Matthew Wilcox <willy@infradead.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	John Groves <John@groves.net>,
	Joanne Koong <joannelkoong@gmail.com>,
	Bernd Schubert <bernd@bsbernd.com>,
	John Groves <john@jagalactic.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Bernd Schubert <bschubert@ddn.com>,
	Alison Schofield <alison.schofield@intel.com>,
	John Groves <jgroves@micron.com>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>, Jan Kara <jack@suse.cz>,
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
Message-ID: <ad-vnqRrUGs9n0N8@gourry-fedora-PF4VCD3F>
References: <adlBcwJjLOQDAR65@groves.net>
 <CAJnrk1a06zkUmXW5EFiUmgAoFauwtzsYvnotaPH0ifVtyh7iDQ@mail.gmail.com>
 <CAJfpegvVTcV89=q3L326aGQjhduBcv7PVg5QKftGLjNZmCLmaw@mail.gmail.com>
 <ad4_jFsR951c2Mtn@groves.net>
 <20260414185740.GA604658@frogsfrogsfrogs>
 <ad69tTnx5YkD4Y9K@gourry-fedora-PF4VCD3F>
 <f254f6fc-dc06-4612-82d7-35bb10dbd32e@kernel.org>
 <ad-UAMcALRubBcHk@gourry-fedora-PF4VCD3F>
 <CAJfpegsUVv0ziMSQiq9pKeXf6G-+LROPTW077hHMSmAirVCLQw@mail.gmail.com>
 <ad-qSB4oL5D3S-ht@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad-qSB4oL5D3S-ht@casper.infradead.org>

On Wed, Apr 15, 2026 at 04:10:00PM +0100, Matthew Wilcox wrote:
> On Wed, Apr 15, 2026 at 04:04:50PM +0200, Miklos Szeredi wrote:
> > On Wed, 15 Apr 2026 at 15:35, Gregory Price <gourry@gourry.net> wrote:
> > 
> > > This was my first reaction when I realized the BPF program would be
> > > controlling iomap return value in the fault path.  Big ol' (!)  popped
> > > up over my head.
> > 
> > I'm wondering which part of this triggers the big (!).
> > 
> > BPF program being run in the fault path?
> > 
> > Or that the return value from the BPF function is used as iomap?
> > 
> > Or something else?
> 
> If a BPF program controls what memory address a fault now allows access
> to, who validates that this is a memory address within the purview of
> the BPF program, and not, say, the address of the kernel page tables?
> 
> (I have done no looking to determine if this is already considered)

From an initial look at the existing bpf ops structures, I do not see
any other struct with a similar (obvious) pattern - so it's not clear to
me such a concern has been exposed elsewhere or directly addressed.

There is a verifier step for the BPF program that in theory would
validate the range matches the DAX ranges, but i think that only
validates the types are right and only on load - I think the BPF
program itself would be the address validater, which is a strong no.

BPF folks please correct me if i'm off base here.

My initial take is that it's a real concern a "bug" in a BPF program
could let userland map arbitrary memory into userland page tables, and
such an extension would not be a quick fix to the FAMFS problem.

~Gregory
