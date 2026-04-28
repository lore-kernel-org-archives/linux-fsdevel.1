Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E229839891F;
	Tue, 28 Apr 2026 10:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777372695; cv=none; b=mtmXIibVVVooG1ZTa5GdPCBAe5ixd6Q9Eha+GoNVhes/i9ygZijKT/h0JoJvUG1tpkFZySHip00ia5Ba3qKFcY7VuqpW7f5xWrYJ2faqbLCCgTYhNYVlySF5joPzvYRli9oZaRE5sxAXMdfA71tVdvZ/hiZjck8MepGgYQ++d/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777372695; c=relaxed/simple;
	bh=So69R0bmKgThLP0Qhn1tJvC/vxhCFKGDMqd5bijVsFQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W/LA2xhBGGmyPTqGVMuQNx9bTEJIXuwI3k4PBlLFbOafTEchQ8zCqCnIFC0+D+k0++Jx7Me2sYUbSXKq11r9XR9MF7mRPr8+nczVR/s57PkJT7zVnj19ShgdjEsYOpohv0kmgkLpFJjr7+pmNqOtLUYvWccGTXwsIPrH7SxvfLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=K0ppNlW7; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="K0ppNlW7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=OsGR73PNsmM67HJ3JifroqoVGn6xSwl9f47zk4PbTs4=;
	b=K0ppNlW7GJuN0/g/IerbxPzoynzCzkztI5JyhySLDTshWls7w2lIoPs4QZJj8N
	pUJrv6o7dUT4tfCX4gm6KcxsYhCfXt+xG0/LkIvtyZQNZ1Sld2qB+bKqP1ba1dmt
	8RiXqW3Dw2qWPYZVWBI65dXZthI+6ylk1HK86TX22EcUY=
Received: from [192.168.56.68] (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgDnb0GvjfBpkGGqCA--.49305S2;
	Tue, 28 Apr 2026 18:36:39 +0800 (CST)
Message-ID: <2ab135f3-aedf-43ec-b5b1-387776803b9c@163.com>
Date: Tue, 28 Apr 2026 18:36:27 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 v2] Documentation: proc: fix section numbering in table
 of contents
To: Jonathan Corbet <corbet@lwn.net>, Randy Dunlap <rdunlap@infradead.org>,
 skhan@linuxfoundation.org, cyphar@cyphar.com, vbabka@kernel.org,
 surenb@google.com
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-doc@vger.kernel.org, Baolin Liu <liubaolin@kylinos.cn>
References: <20260424090654.19229-1-liubaolin12138@163.com>
 <df3b6729-ed3b-42e3-9a8a-f77ebf827dd7@infradead.org>
 <87wlxspw1j.fsf@trenco.lwn.net>
 <9455d5d6-80b7-4c0a-a569-fef3bd9f1529@163.com>
 <87ik9bmphp.fsf@trenco.lwn.net>
From: liubaolin <liubaolin12138@163.com>
In-Reply-To: <87ik9bmphp.fsf@trenco.lwn.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PSgvCgDnb0GvjfBpkGGqCA--.49305S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7WF1xKFy7GFW7Wr13tF43KFg_yoW5Jry8pa
	4Y9r42kwnrK3WUCrnrZw4xJr4fAa4fK3W7JF9Fqr1xJrn0qryfKr13tF4YvF1kGrZ5ua1j
	qF17Kry5Cry2yFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UOzV8UUUUU=
X-CM-SenderInfo: xolxutxrol0iasrtmqqrwthudrp/xtbCwhcn8WnwjbdHUwAA30


在 2026/4/28 16:57, Jonathan Corbet 写道:
> Your use of HTML email almost certainly prevents your messages from
> making it onto the lists; you need to stop doing that.
> 
I apologize, there was a problem with my newly set up email environment 
that caused the HTML email to be sent. I will pay attention to this in 
the future.

> liubaolin <liubaolin12138@163.com> writes:
> 
>>          I mainly work on ext4 kernel development. Recently, I've been
>> implementing a feature that changes the usage of the ext4 proc
>> parameter mb_stats, which requires updating the ext4 proc parameter
>> documentation.  Currently, the ext4 proc parameter documentation is
>> explained in two files: "Documentation/admin-guide/ext4.rst" and
>> "Documentation/filesystems/proc.rst".
>>
>>          However, I found that only the ext4 file system describes the
>> proc parameters in proc.rst, while other file systems such as btrfs
>> and xfs do not describe the proc parameters they use in the file.
>> Personally, I also feel that it is unnecessary to explain the ext4
>> proc parameters in proc.rst.
>>
>>          Therefore, I want to make a change by deleting the "Ext4 file
>> system parameters" section from the proc.rst file.  After
>> modification, the usage and explanation of ext4 proc parameters will
>> only be provided in Documentation/admin-guide/ext4.rst.
> 
> Documenting things twice is obviously not ideal; readers will wonder
> about the truth when they inevitably go out of sync.
> 
>>          If you agree, I will submit a patch to remove the "Ext4 file
>> system parameters" section.  If you disagree, my subsequent
>> modifications to the ext4 proc parameters will be made simultaneously
>> to the two documents: Documentation/admin-guide/ext4.rst and
>> Documentation/filesystems/proc.rst.  I look forward to your comments
>> and replies.
> 
> I think that having a single location for that documentation makes
> sense.  Whether it's in the individual filesystem docs or centrally
> located is up to the filesystem maintainers in the end.  If you move
> that documentation out of Documentation/filesystems/proc.rst, it would
> be good to add links to the filesystem-specific parameters in its place,
> though.
> 
> Longer term, it seems to me that much of what's in that file really
> belongs in the admin guide, though.
> 
> Thanks,
> 
> jon

Okay, thank you for your reply. I will ask the ext4 maintainers, and if 
they agree, I will submit a patch as you suggested.

