Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E803AEF5A;
	Wed, 18 Mar 2026 12:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773836951; cv=none; b=n2lIPmaVuNFmBM+Cz1jHuYi1dggeScdRMbIsSaUW0LQwT1CrkJ0xwROMA+Z+Ym+DO8/JPYy10HHUCjCTxtJLZEB4MvonvmeCIARmKCUMCqkGb8Tw4wydktpbuBKWMRZJBNj+lKsMRtaLz9de/5+zIP6/zMj0AeU7mcK7ipTH1nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773836951; c=relaxed/simple;
	bh=52yhCZj6EIuvXcEe+/gtXO1U8sglreC/gfqc2QduBAc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mAz2bw+AV9/5elG3mdQqHCpHK/g7Sj5IpnI/VnrDU3vQo0c+Mut0ofUYrR4N7GlUhXaz3JkueMtOM/GVZN690lDZeNT34pP67oGtiTnAWAM2L0aNGEJKsrRI5yvRVZQAt+S7fRS/BtNhBYP7+2Uzrvo/rvDNyZnZ8wZo47Mzy8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FrFE+/OG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FrFE+/OG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4796FC19421;
	Wed, 18 Mar 2026 12:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773836950;
	bh=52yhCZj6EIuvXcEe+/gtXO1U8sglreC/gfqc2QduBAc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=FrFE+/OGN2qHOnLro8dsaU5WPjh9QBkfKwtQI002nVbOeaLtX8UkbcYH0cPyn6HKW
	 2w/IzkmftxY4QY+9gtUUmKnpG3Ci57AdHk9d5nMgZDfsQMJzctPC6gT10+QT6b1DOu
	 D7RRYkQXDCEVazOU9v1pRBtyhUaydia6UzNckL5KkYH+GrW09N8Z4Fe5gI1SPOL2tY
	 pBUIa4TieN9hxd5B/nS05ozDFdW8fftL2u1rbjLa9AT+V8QXvCnia7Cwq8AzHkli2L
	 r20wGszNAbgSPD7U6amQYMZQnqPACGef4rf8JMRO+xJAd+o5eb0p3l6M6vVdATIm1r
	 vFXlgSjnwcopQ==
Message-ID: <e19d7d3f-d2f3-4bb0-be4d-af2679673f68@kernel.org>
Date: Wed, 18 Mar 2026 13:29:07 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] fs: Replace user_access_{begin/end} by scoped user
 access
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Thomas Gleixner <tglx@linutronix.de>,
 David Laight <david.laight.linux@gmail.com>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <23f19c88e763beb852a4891b2a908890bdd01b66.1773651096.git.chleroy@kernel.org>
 <CAHk-=whFS7D1M4=cMi9cR06Uoxr1QeM8HUtRB6V3cQth=QNoXg@mail.gmail.com>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <CAHk-=whFS7D1M4=cMi9cR06Uoxr1QeM8HUtRB6V3cQth=QNoXg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 16/03/2026 à 18:12, Linus Torvalds a écrit :
> On Mon, 16 Mar 2026 at 01:53, Christophe Leroy (CS GROUP)
> <chleroy@kernel.org> wrote:
>>
>> -       if (!user_write_access_begin(dirent,
>> -                       (unsigned long)(dirent->d_name + namlen + 1) -
>> -                               (unsigned long)dirent))
>> -               goto efault;
> 
> This was already pretty unreadable (my bad), but..
> 
>> +       scoped_user_write_access_size(dirent, (unsigned long)(dirent->d_name + namlen + 1) -
>> +                                             (unsigned long)dirent, efault) {
> 
> .. in my opinion, this is even worse. It's a 90+ character long line
> (or something), *and* it continues on the next line.
> 
> Yes, yes, the old code was disgusting too, but when changing it for
> something that is supposed to be easier to read, please let's make it
> *really* easier to read.
> 
> (And yes, there's another case of this same pattern a bit later).

The other pattern looks similar but is not exactly the same.

> 
> Adding a helper inline function like dirent_size() might do it. And I
> think it might as well be cleaned up while at it, and make it be
> something like
> 
>      static inline size_t dirent_size(int namelen)
>      {
>          return offsetof(struct linux_dirent, d_name) + namelen + 1;
>      }
> 

...

> 
> Hmm? Can you do at least that dirent_size() kind of cleanup?

Thanks for the suggestion.

I went for a local var alternative, see v4. A helper would be of no help 
as the two patterns are not exactly the same:

	size_t size = offsetof(struct old_linux_dirent, d_name) + namlen + 1;

	size_t size = offsetof(struct compat_old_linux_dirent, d_name) + namlen 
+ 1;


Christophe
