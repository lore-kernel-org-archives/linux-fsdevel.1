Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6566B284B4F;
	Tue, 28 Apr 2026 08:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777366648; cv=none; b=ri/6bpLNA19xwqpF7/w5MMuBNMxFDZW6VY9nPpGSuTQIq3Auww9O4qPT1LpF3Dt2dV78ukQ8gxHJ+tVZCXD4ziM5p9azv3W2pcC9ogRoUcNvoyBz4+pb6ep2vc/TdG2g9L25p5AggXgHvG6Up6Vkbi6aJKOZasllkpqnzm1Xw20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777366648; c=relaxed/simple;
	bh=xclQQIL8NwuCclPKqefRCZG1sgW2GMTH0/6VLG41tk0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kShRGl4p8JtaRwQ8PcuMXLGrdF3+SVZDdYJ66uSCRg66jGq3u67WxDWpd9Rn0AqiXFhxsm/ag7C8ovFbzdlB9yk6oKJLUFWHnMfJHE3cHzgrgP4LuYsOcfl9DE6V2eHZGra+TYMWZOU/gy8EpLSddkJaRjl1vks/cI1V4P0uktM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=OPaA5HaP; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="OPaA5HaP"
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 3DFEA41098
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1777366646; bh=2GBDkqjHSnTS09OIQycXaS4NTzGlXa4b7R9ZaH54qp0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=OPaA5HaPKyEEhkwgoQarllDv6r+yLwuNpS24o5MUQ7cX8nklezUw3jBop0y0PXlPJ
	 wKN3+hjVnlxtHecOFJO/+gpjtqZCkAhBCVd2qDRgUVZdQ+o1xzc9CnZ91idwnxR6il
	 FhKbVbJUoiZAOTpq7cDd8/UyrO4fyNX0379ZLEAItBm6Z4WGCyF888IeFFX4/7Eq3e
	 tMmeXpf2WbvGXln0lTJ3BuvhB9UeUFXbWN5E6h1e724jMC7Gcu107CRc2ckKYT59Fh
	 lgE1/4NNWnOPmPzmlh8aHWyehdQh9QPfBRnBr4G2uwrJDskeeB98KBGvzSRQX9Q44P
	 Z6vG5eRjZhv8w==
Received: from localhost (mdns.lwn.net [45.79.72.68])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 3DFEA41098;
	Tue, 28 Apr 2026 08:57:25 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: liubaolin <liubaolin12138@163.com>, Randy Dunlap
 <rdunlap@infradead.org>, skhan@linuxfoundation.org, cyphar@cyphar.com,
 vbabka@kernel.org, surenb@google.com
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-doc@vger.kernel.org, Baolin Liu <liubaolin@kylinos.cn>
Subject: Re: [PATCH v2 v2] Documentation: proc: fix section numbering in
 table of contents
In-Reply-To: <9455d5d6-80b7-4c0a-a569-fef3bd9f1529@163.com>
References: <20260424090654.19229-1-liubaolin12138@163.com>
 <df3b6729-ed3b-42e3-9a8a-f77ebf827dd7@infradead.org>
 <87wlxspw1j.fsf@trenco.lwn.net>
 <9455d5d6-80b7-4c0a-a569-fef3bd9f1529@163.com>
Date: Tue, 28 Apr 2026 02:57:22 -0600
Message-ID: <87ik9bmphp.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Your use of HTML email almost certainly prevents your messages from
making it onto the lists; you need to stop doing that.

liubaolin <liubaolin12138@163.com> writes:

>         I mainly work on ext4 kernel development. Recently, I've been
> implementing a feature that changes the usage of the ext4 proc
> parameter mb_stats, which requires updating the ext4 proc parameter
> documentation.  Currently, the ext4 proc parameter documentation is
> explained in two files: "Documentation/admin-guide/ext4.rst" and
> "Documentation/filesystems/proc.rst".
>
>         However, I found that only the ext4 file system describes the
> proc parameters in proc.rst, while other file systems such as btrfs
> and xfs do not describe the proc parameters they use in the file.
> Personally, I also feel that it is unnecessary to explain the ext4
> proc parameters in proc.rst.
>
>         Therefore, I want to make a change by deleting the "Ext4 file
> system parameters" section from the proc.rst file.  After
> modification, the usage and explanation of ext4 proc parameters will
> only be provided in Documentation/admin-guide/ext4.rst.

Documenting things twice is obviously not ideal; readers will wonder
about the truth when they inevitably go out of sync.

>         If you agree, I will submit a patch to remove the "Ext4 file
> system parameters" section.  If you disagree, my subsequent
> modifications to the ext4 proc parameters will be made simultaneously
> to the two documents: Documentation/admin-guide/ext4.rst and
> Documentation/filesystems/proc.rst.  I look forward to your comments
> and replies.

I think that having a single location for that documentation makes
sense.  Whether it's in the individual filesystem docs or centrally
located is up to the filesystem maintainers in the end.  If you move
that documentation out of Documentation/filesystems/proc.rst, it would
be good to add links to the filesystem-specific parameters in its place,
though.

Longer term, it seems to me that much of what's in that file really
belongs in the admin guide, though.

Thanks,

jon
