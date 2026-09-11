Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 101A6370D4D
	for <linux-fsdevel@vger.kernel.org>; Fri, 11 Sep 2026 14:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789138198; cv=none; b=Its35Ab4ipKz9ohVKD7KtJLPPIpIDHfQ3Cbm/Q03QW9HEaKvvh6xXAJzfhIYAtgYfZjV0KEPWLO9ISzP/BjuYP8gXFAH2t/PCHmDVJujIHGvac2fVcz1MCckqdItUgSiUjMMnkHYxTg9Y/J8o+QtJHrG4lqRKZOpNvoyZ9Dc/Ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789138198; c=relaxed/simple;
	bh=iRLtMtLNNS4pjEszxOSG75MXP+yV8831MDgLJLg/nZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f9Fjbb5JfZh3MIdJ/0ZLljxKg6SJM3aYmx4ZM7xlOJW/QpSoKi/3rsx2bcNmCYiYE3tprYzbc4cGJTwkyP0anSQPcD9VfsHM9jEnG579xejqlwxy2zHBQXz6oe3lolUGGcG2jJNV09L2aBHnEO23Vey+ST8iaKjZh4whyMgHF0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=hvEixzJJ; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="hvEixzJJ"
Received: from macsyma.thunk.org (pool-108-26-156-127.bstnma.fios.verizon.net [108.26.156.127])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 68BEnVtR020550
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Sep 2026 10:49:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1789138175; bh=gIirZmMyD8vuw/30bMQ5PpWdGiAKPqfRzxdpYzASv1I=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=hvEixzJJgo8G0eU9DUFWLXi3TjQ5xWIJiX55bgRU58OAb1voZOOH6grRQ1adYbWrw
	 Bu3VjKuEQQ3xldgcMN8h14NErpLo4uQTZzSCW+PJB/+JO80W/RIH2qOCmQ5z48j0XH
	 5Iz+3tiRCNCRxIvt7ZCeFMCTH15YVMGjej0aqRRDMtjuyVGnpIidynv+3jJy+a4BAi
	 nRbMed8HOoiS7ms7a1LTvWiFhxVk4NOtlW5LkZffMtsyCIoQsL91Nvc+RR0VPJEeBI
	 Eos02zmBDfVDRQmNCM17EOVrVzp4dy5jiZlFCojBelRjy8uAldPeQcFEaMuqBg+sh4
	 bc5KeGZPdy69A==
Received: by macsyma.thunk.org (Postfix, from userid 15806)
	id DB46F148192C; Fri, 11 Sep 2026 10:48:30 -0400 (EDT)
Date: Fri, 11 Sep 2026 10:48:30 -0400
From: "Theodore Tso" <tytso@mit.edu>
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: Christoph Hellwig <hch@infradead.org>, zlang@redhat.com,
        fstests@vger.kernel.org, glaubitz@physik.fu-berlin.de,
        vdubeyko@coreweave.com, linux-fsdevel@vger.kernel.org,
        frank.li@vivo.com
Subject: Re: [PATCH] xfstests: exclude hfs/hfsplus from generic/339 run
Message-ID: <aqQR6cujdVg5qCFp@mit.edu>
References: <20260910000449.747189-2-slava@dubeyko.com>
 <aqJ--AqubS-CWiV-@infradead.org>
 <aqKzDpccJgkmzC5E@mit.edu>
 <f156a3665404751b29fd21d9ee136f2d66d5fe87.camel@dubeyko.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f156a3665404751b29fd21d9ee136f2d66d5fe87.camel@dubeyko.com>

On Thu, Sep 10, 2026 at 02:14:08PM -0500, Viacheslav Dubeyko wrote:
> 
> Could we have any generic way to detect that file system could not
> support some Unicode characters?

We do have unicode tables which are optionally compiled in if the file
system requires it.  But those tables are from Unicode 12.1, and the
latest version of Unicode is 17.0.  Most of the new characters added
between Unicode 12.1 and Unicode 17.0 are for dead languages that
archeologists and academics care about, and new Emoji's.  So function
will let you know if a Unicode character was considered valid as of
2019.

You're asking a different question, though which is for hfs/hfsplus,
what character are deemed valid by fsck.hfs, right?  And as far as I
know, there is no way to answer that question in the hfs kernel code.
What you could do is to try creating a filename containing a
particular character, and see if the kernel rejects it.  Ext4 and f2fs
will reject such characters if and only if Unicode strict mode is
enbled.  But that's not going to help for hfs unless you add that
support into the kernel....

					- Ted

P.S.  A problem which we haven't really solved is how to add support
for multiple Unicode versions at the same time.  So if someone
imported Unicode 17.0 into the kernel, ext4 and f2fs really require
Unicode 12.1.  Short of supporting both Unicode tables in the sources,
someone would probably have to figure some mechanism (perhaps using
Agentic Engineering) to collapse the two Unicode tables into one, so
you can answer the question, is a particular Unicode valid in 12.1 vs
17.0, and handling the Unicode canonicalization rules for Unicode 12.1
and 17.0 based on some API.  This is the other reason why no one has
bothered updating Unicode, since it would be tricky.

P.P.S.  There is reason why, over a decade ago, when I was talking to
an internationalization expert at an Internet Engineering Task Force,
late at night, at a bar, the expert said jokingly (and when said
expert was very well lubricated), after reviewing all of the
engineering challeges of getting I18N correct, "It would be easier to
teach them all English."  :-)

Mercifully, we only need to solve a very tiny subset of the I18N
problem in the kernel.  :-)   :-)   :-)
