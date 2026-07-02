Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16DD83A83AC;
	Thu,  2 Jul 2026 16:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783009778; cv=none; b=NY0XQU5R8dnezoQHNrc9bP3s5JclutzoiLE0FSBG1g7ukYW4zwJYdvzN2iP3dZGAVzO2E4yBbsy5CTNq6eH9BYfjVJlVJZtZ3UBqeUUnIv4CxFxswZMTysAJEdN9RXA4tyDmC0eQrknoqO3cWZNUnRDh0Jgmm0nNNnUUpBZiMYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783009778; c=relaxed/simple;
	bh=T2h39zdyPIPtjb2Qpyo15fSXK8QPl8IEyg/B6Ms8gEs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WJdKBz2BdqrkxKbsiU/W6+zh7JIeauo9G5KcwfXCreIe1HrUiwLnNcqT7x3+azdYQzJmSxvU/EOMeQtgkP42/zTMAYdQo6DmhWNRTIKZFBiV9EWh53FNoxZTKl/LgQTF10AZ1GkkcqAj0EZpseT5M22ANRB76LheQQNS6E8e45U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PkErobcu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PkErobcu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00C7E1F00A3D;
	Thu,  2 Jul 2026 16:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783009775;
	bh=T2h39zdyPIPtjb2Qpyo15fSXK8QPl8IEyg/B6Ms8gEs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=PkErobcuES/0G07JpaCQu3n7TJ+zeLFzfROrPjVkBQbfK9uuKWG0BrUWsJQzfrt1a
	 scAEzEnOxPmWyA9VdoHryO7gMjRmRvGZUsHzqL/rIvodPVKQXgMBSyn4rIlrqAkpSv
	 4UJVgTUnf0JIwMjyoFKd/kCmsMfqQOzhRrXLYCmsu33a1hJh0RapyXBuxrEvfDX+UT
	 m1Kd5YLNgZZJxkGUEIh61WyfJzmK+V5FhgvjfDPr6yMQuz1tBg2CIqBzuYg2kG2u1j
	 E+J0Rj1e/xqRdagvAMJ9lF4cocxJsGsTIbp5xUJDzMHlRIw0boFHIeZPF5f7981sjP
	 ZFv5FvTi0X4tg==
Date: Thu, 2 Jul 2026 17:29:25 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Jonathan Corbet <corbet@lwn.net>, Jens Axboe <axboe@kernel.dk>, 
	Jeff Layton <jlayton@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, workflows@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: [PATCH RFC] coding-assistants: simplify attribution
Message-ID: <akaRyUtHdNaUNElw@lucifer>
References: <5e7b9d23-4291-48fb-bdc6-47db82d33c80@kernel.org>
 <20260702-seekrank-stilrichtung-mitentscheiden-69a64ee097ec@brauner>
 <1f29f48d-b9ff-4de2-a392-dc05781728be@kernel.org>
 <akYz2aMIco1fbD-t@lucifer>
 <54d3a698-a275-488e-ad36-ef423db30f70@kernel.org>
 <20260702-weitreichend-aufgearbeitet-flausen-fd92f38bbba0@brauner>
 <akZqigap0GTOSkyx@lucifer>
 <20260702-angewachsen-glatze-kassen-61b7761f6564@brauner>
 <akZzDfK-yr5ErVJT@lucifer>
 <20260702-jagdrevier-halfen-paragraf-442896b3a5a0@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260702-jagdrevier-halfen-paragraf-442896b3a5a0@brauner>

On Thu, Jul 02, 2026 at 06:18:45PM +0200, Christian Brauner wrote:
> > I don't understand that at all. The coding assistants document is not being
> > deleted, and if you read https://docs.kernel.org/process/generated-content.html
> > you can see it doesn't enforce tags.
>
> I think that was a misunderstanding. I just wasn't clear on what you
> wanted to do.
>

Ack ok thanks :) maybe I wasn't clear about it, really just wanting to make sure
reader of one doc is aware of the other, will be a trivial patch.

Cheers, Lorenzo
