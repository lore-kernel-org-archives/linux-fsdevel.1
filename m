Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE2D320A14
	for <linux-fsdevel@vger.kernel.org>; Sun, 23 Aug 2026 16:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787503401; cv=none; b=ROuzWWn5x6bfqI/GXD/KO5k7OmsMve6Wvh0OGPG2t+KcpMM8uzmL8LL4BzBoQmJpmYxdckJAl51xhb0WJl6S1QAcmKbsQ5VJfwdqfTm4JbpVRjl8VXMOvp7ZOsAcuIbMJD46ony+qoOoU0vC4rcicnA5MUbSh8zgRCG/yCf8oc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787503401; c=relaxed/simple;
	bh=pWDzkQYpINPFTZeR8thS8nOa7PK6nZSbqUQipGA4xXM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qXjpRPBZf5UTb4MIb0bGkP7lLIOXQvx0H6977tfO7kuMEEZsatKgZS8yIxYxRYoxPXhP5WFsh8AOt0REwflp4UsdnGlleC0aGIgGszZ7Iaq7qKb/pxFJowhl6DuU1qc0ViSaqJNnRaNYBX7A3a6C0Lf9UWl4IrTlTXNCbJ1bNfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=D3oYCTlz; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="D3oYCTlz"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-51c2cce930cso27635801cf.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 23 Aug 2026 09:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1787503398; x=1788108198; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4EA5wtk151L22kFWX4iHeihngZ8TcErsEBYYtEmRpXE=;
        b=D3oYCTlz7ZV/CP8G0eG7QNXAoBrIdfkDLHRo+V+aL5ugG28nejEPsP1eNMKS/brxA1
         WeW8zr3GnTTPNXbO+bYNvs09T0J/cnUU+zlsIF7Fqd8aa02uhuwWO1ZM8EvgyE4k0Z/p
         6gfNs4RnxepRMu4lJr093Kr2yX/067r54D4+Eg7QVN4z+tD2qGKKihOEEmcmecOoQ6ed
         3HwpG7ytChYL/0RILqtER+MvdyCH8C0rJWP3pePI6O1VwSkZHuaqhJWjSM05KHRInsED
         vkbylTcdZmmN2ysybcTKO5NM8OxpeUjplAheXrTpkM/8fUg8/znHDMt/UXkvdyAKTHyM
         fgaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787503398; x=1788108198;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4EA5wtk151L22kFWX4iHeihngZ8TcErsEBYYtEmRpXE=;
        b=DgnG1XBW45zQnRQ7Bbn+OucYkQvwSA8/cqilUG9MFlDPxaGqGg1jMZJdy6ce7DKFGI
         DPSHOFW3B/ItD8nZIS1aRRmpyhn3CSn9jnm9ByyQifLIiyiez0gx1azn1NfcvdH21o+k
         SyL2nwrpBcmX3D8IpcjqlLJUG/il8irrsiaui43A4xKFz3v1QlKjv8KfVt3qCXBYDlWy
         mnnasuHbpFl0NNI6hjcQeOYSvhp+vQhZxt0qzsEgABvlKH21K/s2n+MScu2xuk7J3cmy
         1VOu/6d1t2J7XkILENJe/1PP1rd/XrE4YT9JbXGiOR+PNzK+ccT3joenhkLVMUodUN5f
         rTwg==
X-Forwarded-Encrypted: i=1; AHgh+RoQzpRzBf5epgQ0FRf/9bLcDSrpP/PwUmlJUtI5cfFdNPxtbtSlUobcukknteOWcIArxQLvByygdY8MHwy8@vger.kernel.org
X-Gm-Message-State: AFuF++kHY4mUU/aWTBafEayP8NPXi0REZoB1zIvJVnPtSEa5knWpfCQJ
	rCHuuIZqB8XdVEqLySonEIFk9XSlEqnuW6ovsWFSj5c0ccqZGqJUFtVtQC91dZCNfic=
X-Gm-Gg: AR+sD11oJwUs71q811dtKcNaiMQrKgmgwsx84kXiJ+Sjtbb5YOtvNO/q3tGOR4NRUkZ
	lIh3CT/cpxbgtlIrrXRtin3Ar0za5AeY4rAMi/kLWsQRvBrzNTCelttF/unmsk9i0DnXcUomr9f
	y4s5VKOUmQaylVj8uPGir23R2ZNV8iuc41fcTTNiopU++nk9/WmNSPwUagvGbBseXOIiCNQuMoj
	ic6+ETTkqZ7hnxdom2G4yeHlob77wNvA2oJIfFo/KnJXZhUX80vS8WG+JWh7BBhnfSxOWjosK7T
	Vps3AfZuO+0Kx1piddXPYMwZOy7h3oqqZU6AOYiEXAi1oYp3DedkAzO0kUZ5EnpXOSl1PDGRa+6
	qCvg7afJch5JH8pEn+R/vwFTFO3mZkSoaKuUruguCLZlsEmFDxOXRUBi94VhtpZJ82E3cvyUM4P
	cFIO4ANAOO2X+GC5O19r5XukzQAqtub+vCpwuKkkv2zEOA9i0jRl4zXYBDZgtvSOxbewQRjsfr6
	6HYFgsIDHwoocHGHswOaRqOMfET/VEJJw1z53YqRod1c0cn1ObxWmk=
X-Received: by 2002:a05:622a:90e:b0:51c:1fd1:e755 with SMTP id d75a77b69052e-52df59e7e7amr219365661cf.36.1787503398278;
        Sun, 23 Aug 2026 09:43:18 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90c9361720bsm41074616d6.21.2026.08.23.09.43.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2026 09:43:17 -0700 (PDT)
Date: Sun, 23 Aug 2026 12:43:14 -0400
From: Gregory Price <gourry@gourry.net>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: John Groves <john@jagalactic.com>, John Groves <John@groves.net>, 
	Miklos Szeredi <miklos@szeredi.hu>, Dan Williams <djbw@kernel.org>, 
	Bernd Schubert <bschubert@ddn.com>, Alison Schofield <alison.schofield@intel.com>, 
	John Groves <jgroves@micron.com>, Jonathan Corbet <corbet@lwn.net>, Jake Edge <jake@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Vishal Verma <vishal.l.verma@intel.com>, 
	Dave Jiang <dave.jiang@intel.com>, Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, David Hildenbrand <david@kernel.org>, 
	Christian Brauner <brauner@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Jeff Layton <jlayton@kernel.org>, Amir Goldstein <amir73il@gmail.com>, 
	Jonathan Cameron <jic23@kernel.org>, Stefan Hajnoczi <shajnocz@redhat.com>, 
	Joanne Koong <joannelkoong@gmail.com>, Josef Bacik <josef@toxicpanda.com>, 
	Bagas Sanjaya <bagasdotme@gmail.com>, Chen Linxuan <chenlinxuan@uniontech.com>, 
	James Morse <james.morse@arm.com>, Fuad Tabba <tabba@google.com>, 
	Sean Christopherson <seanjc@google.com>, Shivank Garg <shivankg@amd.com>, 
	Ackerley Tng <ackerleytng@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Namjae Jeon <linkinjeon@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ira Weiny <iweiny@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Haren Myneni <haren@linux.ibm.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Giovanni Cabiddu <giovanni.cabiddu@intel.com>, 
	Jiri Slaby <jirislaby@kernel.org>, Ethan Nelson-Moore <enelsonmoore@gmail.com>, 
	Gabriel Whigham <gabewhigham@gmail.com>, Aravind Ramesh <arramesh@micron.com>, 
	Ajay Joshi <ajayjoshi@micron.com>, "venkataravis@micron.com" <venkataravis@micron.com>, 
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>, "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "fuse-devel@lists.linux.dev" <fuse-devel@lists.linux.dev>
Subject: Re: [PATCH v13 10/12] famfs: Add runtime operation-permission (opts)
 framework
Message-ID: <aosejKmNJxCIpQho@gourry-fedora-PF4VCD3F>
References: <0100019fed5850ec-2bdfb17a-3086-44ea-8fdd-777d3ce12a33-000000@email.amazonses.com>
 <20260810202539.96378-1-john@jagalactic.com>
 <0100019fed5a5210-a09f1bdb-c705-44fc-8108-a7e7995a7af0-000000@email.amazonses.com>
 <20260822000728.GB6047@frogsfrogsfrogs>
 <aokdSo9li0RtEt35@gourry-fedora-PF4VCD3F>
 <20260822174029.GC6110@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260822174029.GC6110@frogsfrogsfrogs>

On Sat, Aug 22, 2026 at 10:40:29AM -0700, Darrick J. Wong wrote:
> 
> A bigger question I just thought of is sharing cxlmem between files (aka
> reflink).  Is that allowed?  I could see a theoretical usecase for
> programs A and B wanting to share some cxlmem for communication or
> heartbeats whilst having their own /a and /b files for their private
> memory.  Probably you'd just create a /common file to do that and not
> map the same cxlmem page into /a and /b, right?
> 

If the underlying memory hardware is hardware-coherent, then this would
be supportable because the coherence domains of all the hosts connected
to the large pool would extend to one another.

In our current world, these huge-memory distributed memory systems are
non-coherent and each host's coherence domain stops more or less at the
head it uses to connect to the shared media (it's probably more accurate
to say it's "device dependant" but that's besides the point).

Anyway, there's "allowed" and "useful".  You could technically do it
(maybe not with FAMFS' current guard rails) - but it would be useless
unless Process A and Process B were in the same coherence domain.

~Gregory
