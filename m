Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E5F64C0437;
	Thu,  2 Jul 2026 14:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783001361; cv=none; b=mCf/actJcLWWLApnFWcbPNFU8H9IjaZjQHNesDQxQKl1QmzRfBCUcd/9V+bUNsUjVWUD6UHQ6loUrbMvANmtlJ3F3Xen2/vRCSp9kuoUbi3nr7VgFXu+x36LO5WDpIqh6q4R6t5CqoMXvF5f3P6FMnLW0ajW5kB/WOJwRP7GPYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783001361; c=relaxed/simple;
	bh=IvE61PuLXfGbmO1k4qX+HKiiz0LQPH6/nktPJ0/RztU=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=LvGvM+66Z/OBmqDhpRMp2+H483/lJmnEeEBh/61+oRRfXeKBqOAhM6zFrL6MYzXExqapAm4kBzVMQXB5OEw/KFsrObR7YfnYVVjXkynU0XwKN/rS2UWAXuM9cfGvsSdDlI8WZv8u8PHItKtrhMy8lyva5T972g09sURNd/07654=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ld6AbBrl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ld6AbBrl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FFCF1F000E9;
	Thu,  2 Jul 2026 14:09:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783001360;
	bh=QGJysTifjaBTc1Wq80zUMCvLFgDxEVRXcP5jQBdhyJs=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=ld6AbBrlLz1TcvA2W3xDbz5JsKoPOy7UCMhGsAaK7GZ2yD5xBnWK0oL0aLU/FEuRp
	 4Q+Btl9SKe+zSWuH5/f0Z7sPQ9kmiOHN5WiRmvRuiO1BW2cTwVqTcEa9bqYbJbEjyg
	 22seUeOTn/68Wze4DL9Kl1lYskO9jxKGRnzSYKDQRaq0iD9dFhHFBpZgywNV6c2277
	 1WgXCKN8p32jlrfyiiqHMXNH1J+dMpHl1PqMNBZnVtNhnHdOkiyP2RWAriFCu52tEz
	 ivepOsad91r+Ml5JzCxZRkevBfYhFp0uF+zeVXt89f/mJCQE502aCxlnO9n+8c9se+
	 SYDXosylp6nuQ==
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH RFC] coding-assistants: simplify attribution
From: Christian Brauner <brauner@kernel.org>
To: Lorenzo Stoakes <ljs@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>, 
 "David Hildenbrand (Arm)" <david@kernel.org>, 
 Linus Torvalds <torvalds@linux-foundation.org>, 
 Jonathan Corbet <corbet@lwn.net>, Jens Axboe <axboe@kernel.dk>, 
 Jeff Layton <jlayton@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, 
 workflows@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>
In-Reply-To: <akZqigap0GTOSkyx@lucifer>
References: <20260701-work-coding-assistants-v1-1-a20a94d1d606@kernel.org>
 <5e7b9d23-4291-48fb-bdc6-47db82d33c80@kernel.org>
 <20260702-seekrank-stilrichtung-mitentscheiden-69a64ee097ec@brauner>
 <1f29f48d-b9ff-4de2-a392-dc05781728be@kernel.org>
 <akYz2aMIco1fbD-t@lucifer>
 <54d3a698-a275-488e-ad36-ef423db30f70@kernel.org>
 <20260702-weitreichend-aufgearbeitet-flausen-fd92f38bbba0@brauner>
 <akZqigap0GTOSkyx@lucifer>
Date: Thu, 02 Jul 2026 16:09:14 +0200
Message-Id: <20260702-angewachsen-glatze-kassen-61b7761f6564@brauner>
X-Mailer: b4 0.16-dev-4217c
X-Developer-Signature: v=1; a=openpgp-sha256; l=721; i=brauner@kernel.org;
 h=from:subject:message-id; bh=IvE61PuLXfGbmO1k4qX+HKiiz0LQPH6/nktPJ0/RztU=;
 b=kA0DAAoWkcYbwGV43KIByyZiAGpGcQyjse6Yhb47wGViqQKBUm75KFTygsV2NQaT0cfHFnR/6
 oh1BAAWCgAdFiEEQIc0Vx6nDHizMmkokcYbwGV43KIFAmpGcQwACgkQkcYbwGV43KI+agD/b9vq
 b7cFSi6de/+W9UrfVCLO8yOQR2bsE7mMoP+RRQ4A+wTVUKAugUGkvYlUY2uImqCEdGyf0ewMfiR
 2QvAQOZMM
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

> > I think as a global policy this has ran its course.
> 
> I'm honestly not sure why you sent this patch in the first place if you're
> simply going to ignore it (+ people's opinions) anyway :)

I sent an RFC patch for the minimal acceptable change in my opinion. It
turns out that the majority of people on here seem to prefer the removal
that I mentioned as an alternative in the commit message instead and it
already happens in practice.

> I'll still send a patch to link the apparently redundant AI doc to the generated
> tooling doc because for those who do pay attention it's silly that they're not
> connected.

This on the other hand seems a bit strange given the direction of this
discussion.

