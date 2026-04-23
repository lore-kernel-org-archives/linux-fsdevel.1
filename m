Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3922F6931
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Apr 2026 21:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776978594; cv=none; b=nTfKwUokEm/um82tjUWom8IC6UnVt8o8X2BQN8vNFTWtqO3JhLUwomyGERGpCA2A5LQQnlQtjRSM/Y9CEszYZSV5OZLAefY+kInXhdejZXxPq5+z6kmE+iZZ+nsFRMoS0qvJRH4JYckYjR0m72MW2y2cms0wEX26b1RU7IanAxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776978594; c=relaxed/simple;
	bh=QMhOAg1Tph5EIXJUZJGCuoxrD35G+YiX3fNBbCa1ks4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C9D907gMuY9h/9KLS7QAabMoSpyi4K6rGxkD2j0zhRo2aOAa3LtAfFay+Dm8ancSoURKAY3BuB2XEAkSs5V7wx1QxKuG4xqpqibb3zd32mz6Zl5v4WLwPOPOyeqEVWgJIvpbxpFEdmEwPWcnDfu3HdswHtoJAnMGGwdLhaEeTqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=gMsUpl1d; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="gMsUpl1d"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ba7a1cc0380so1051353466b.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Apr 2026 14:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1776978591; x=1777583391; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=flvI8an6GbQNr76WjrirwCQpfSDzRfN4t1QXS7wLejY=;
        b=gMsUpl1dc83dXJ3NveGDIAlmydHENdtW7Vco0QmyzdS0oWoZd5jfhl3sTwZtNfBoVD
         mns+ZzCQUvT9pR+GWQsROwp22tAD8SuuSzRrlEA8EwMl7v3QS/aZ0PDQt5RheOQdTHT+
         JsmFVXi7D3Z5Xp7Lo3Q68OPsWLF98QVXAoWNo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776978591; x=1777583391;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=flvI8an6GbQNr76WjrirwCQpfSDzRfN4t1QXS7wLejY=;
        b=pI5RoiC1E0of9uFI1/RFxO2jQt3FKeyTEdC+emWPJDMRrTOno6+i3iJK6nfoerRxxh
         whZcmQ0MKGfwo1NfB0H3o+3kJph9F+qwvKSbCwQomSmvqu9E/UosDyt50OEuA4TGBHub
         z7cBSX7ZwCE3qR3GSQi6IcWIcIIyZFl83g2JLvmPnhNZb/ZJjUW/lfzPfWGdWM9j4UzU
         tasxLtQEfisSqIBTjt1T3WIrJw6Gujcr4Jg+4e0FhmM3m75RyO97cvNSJjqEOpe1EgRy
         aJEDmMU6UBlgbVVUPfeaZga45gL4g4kQiQS8qxfea9HEbZYzDgKidXx7qQBMhcYbw+xO
         6SGA==
X-Gm-Message-State: AOJu0Yyv34nBYvlhXwQ8BrAIERbV4p9k4S29rQMY7DmR/zP75eMb6Shk
	0pWlDQ9ZUj7fSVhhgTe+qngqwAFM/QjJHHGmR3xR7icFV0PzCjVEeuyGri2+wcaEHUY8XR7lArs
	7QwcTfc0C7g==
X-Gm-Gg: AeBDiet0rCTw/5nFu0aNQn9TN2NSSU5DoEKVaUqMV6DSeqRgQTPXrG2Ik82NKklBnnp
	vqC9XMhAA7W7cSVIkvLQmr3XbkVGXnSOEeXLcR1eKv36L5xITw1Tsp+c0wAyi7sqUP4ypWPKTl3
	73QCzleAkhe9QHLncALgDu05rZcprcechBESSNIOekU+L5Yrg0o2gNf+fk932j1PtCjlX70sw7q
	E8Llr3pDlgf9yTS96+wbL+hiX0+H//nPeq7f8M6nWiP+PaInm9xI3pcgdGlLAKbhaYUJvvEOtLu
	ZhLgKJJRR33PNIRDs5VajfOR1bq+jnlX/jEHdxOqsWIxnrFnEKWkykBr23Jg6g26y1jeA3CnfHh
	/bVZfiyf+9EezAA71VJUvcW/mfJD6b574gNr+CTcaKVOcKZ+eMYTZRuhFWI1R3MtSKNUzMIeaNt
	5gKpdM6x4RnDWeptDYKSqvJNDfrU6dr+Lchdo/aDx2z8Y7pg847b0H2DQK4OoRo0MCk6g5jO6kH
	4LrS03owq4=
X-Received: by 2002:a17:907:d87:b0:ba6:cb4c:bd3 with SMTP id a640c23a62f3a-ba6cb4c0f80mr1131790366b.11.1776978590761;
        Thu, 23 Apr 2026 14:09:50 -0700 (PDT)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ba4517ee077sm713738166b.18.2026.04.23.14.09.49
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Apr 2026 14:09:49 -0700 (PDT)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-66e8cf72a93so8607561a12.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Apr 2026 14:09:49 -0700 (PDT)
X-Received: by 2002:a05:6402:159a:b0:66f:2ea5:c269 with SMTP id
 4fb4d7f45d1cf-672bfdc97e3mr12090026a12.15.1776978589730; Thu, 23 Apr 2026
 14:09:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260423182917.GP3518998@ZenIV>
In-Reply-To: <20260423182917.GP3518998@ZenIV>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 23 Apr 2026 14:09:33 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh_tDKXkzoS23NMtUW9JXTOLEKo73jNNP9hfWeisXZQOA@mail.gmail.com>
X-Gm-Features: AQROBzDzlIaZlxmU_QlBSzGANzVBeJVsnj3yckgx3K6u6PaQDATDBETcwNw9MO8
Message-ID: <CAHk-=wh_tDKXkzoS23NMtUW9JXTOLEKo73jNNP9hfWeisXZQOA@mail.gmail.com>
Subject: Re: [RFC] shrinking rcu_read_lock() scope in d_alloc_parallel()
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, "Paul E. McKenney" <paulmck@kernel.org>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"

On Thu, 23 Apr 2026 at 11:29, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
>         Does anybody see any problems with something like the delta below
> (on top of current mainline)?

My only reaction was "why do we take the dentry lock for d_wait_lookup"?

I think it's because d_wait aliases with d_lru, so we have to
serialize that whole thing, but I wish that was a bit more obvious
from the source.

So your patch looks sane to me, but maybe add a note about why that
in-lookup wait really wants the d_lock (which is what then make that
path no longe ruse the lockref_not_dead thing).

               Linus
