Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43F4C36AB4A;
	Tue, 24 Mar 2026 11:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774352566; cv=none; b=q9I4AmDzcCL1f5CSh/dXGlANdyEyxqnpiU+lfdBB72QPzX8+tFX2AqViztzyISTbcFrz58FImCauit+E/bZu49ijxyJdT78WIVscN+q+JBy52Ch/Kt90CqXZYFmmNJx/ttc37ytKmU89xrheRrruGJysjlPFEBzuNtrZ8JoSfB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774352566; c=relaxed/simple;
	bh=wkEa1Y1Z4LOYa1H14bijqOaRGxeeDh/zX/UAEchFIUs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ctg/IE9ji/+TrePtovdRMNcMnNCdWG9I0G2W9tg70fPFQg2Q4p3K60QRjSIk0p14t05wMDx0/6KDOvyzHWvwljfAqzM2Vi4mGbXEMn/CJ00KQheoaFvumGrYrlFhvJ3e9sNNgr02tqlQpLj5Of2IoTRTFA/QNf9NMmzGRBFTGTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dCRGXo2t; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dCRGXo2t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 726DBC19424;
	Tue, 24 Mar 2026 11:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774352565;
	bh=wkEa1Y1Z4LOYa1H14bijqOaRGxeeDh/zX/UAEchFIUs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=dCRGXo2tmTU9aD/RK/MErlJrh1Y+u/EH9rc8PTbM5MeS56JqU20TqI7errdHao4pM
	 hJ8PJVZCyHnzmj5Sx6t9xFQpU6li20nC/FQAO04LbCztPhIgwLrnaVeTLx6h5g0YXn
	 3P+CFtI4uQk78OgXkU+8SEPnLsBFsgLvTKBzaUdcsgN+pJO23U9HWnLGjFmCWBaEFn
	 zjXH04XnY8XPIfKXgWyYdzIkxDoODxUxOW8lVBGpbMsqiUMQX7OPJcxs364ky64nbE
	 y/4LWNS7o7W0pqRIuDHFr223AdGLLbC3gWYuMHior6EZwxfB5C2hjlItjwsI+Pb5lZ
	 HVKCWJr7UvzMQ==
Message-ID: <b4565127-2ee3-4776-acea-ee47f65672ff@kernel.org>
Date: Tue, 24 Mar 2026 12:42:40 +0100
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
 <e19d7d3f-d2f3-4bb0-be4d-af2679673f68@kernel.org>
 <CAHk-=wiJVSCmiQAQYYjdQqo9Z1k7WQcep2qW+DiqHyP7Y1_SnQ@mail.gmail.com>
 <CAHk-=widw8GwXNuq5ALr+NgDDUN+=pc77U=EczqUiVZeD2Dz+Q@mail.gmail.com>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <CAHk-=widw8GwXNuq5ALr+NgDDUN+=pc77U=EczqUiVZeD2Dz+Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 18/03/2026 à 16:53, Linus Torvalds a écrit :
> On Wed, 18 Mar 2026 at 08:49, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>>
>>      #define dirent_size(dirent, len) offsetof(typeof(dirent), d_name[len])
> 
> That 'typeof(dirent)' needs to be 'typeof(*(dirent))' to be convenient.
> 
> It was correct in the patch I attached, but I'll just point it out anyway.
> 
> And we actually have a helper macro for that: struct_offset(). Which
> wasn't what I used in that attached patch, but *should* have been.
> 
> IOW, the macro should look something like
> 
>      #define dirent_size(dirent, len) struct_offset(dirent, d_name[len])
> 

Sending v5 (series of 2) with your suggested patch as patch 1.

Following feedback from David which I tend to agree with, I left it as 
you did initialy.

struct_offset() has only one caller and I don't feel it has much added 
value compared to offsetof(typeof(),) pattern which is more explicit and 
already used 144 times in the kernel:

$ git grep "offsetof(typeof(" | wc -l
144

Christophe
