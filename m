Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B533CE49E;
	Fri, 20 Mar 2026 17:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774028174; cv=none; b=KUtEp8i5lqwL/wqJT3qjgpYI83FhCB7ycRBM/fswaRZyYWhB/aNPq7eDOsrj9q/uBZriqFqz8PDjK5dRb3rmyNZfCu90xMPR3CWN2pFe3aahEErwb155G1BTrKD26qNVSP8QVrnQbINCh2e08wX7h5glYO/lUncdxTQgHFrnSc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774028174; c=relaxed/simple;
	bh=Z0T454zE/FwU6NDhHxmFnJ7rG7yJCFlief2b/W3QrSM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ERfzQV1nZV3ctrYEQXtWQwESYkq+DfmSdEALcsVt+bV5tJRt6z8UaPsjG97Hlh2qd6dOPgRAyaOc0//AEeTVP/A3nRhncB/QPMQaVM9jlYx8CwE8wUmIe6cwFJx/iBUdc12ORzutZ13xfQvRtTfWHjmDWZQxWk98eyTNKdkr3YU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kW1YpS5h; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kW1YpS5h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88C22C19425;
	Fri, 20 Mar 2026 17:36:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774028174;
	bh=Z0T454zE/FwU6NDhHxmFnJ7rG7yJCFlief2b/W3QrSM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=kW1YpS5hE9/9uAl8t2g7O2h+bHG/ecN3Yz4B+uKMpsbJjCgczLpjQ5wqYRuF0D5YX
	 WnFQvAjdMBsi+rh2eGe/ZJHIJBQRVlI7ClKBdveKan8sJkKWfqc4JD5hGJ0FZqRxf9
	 JjR7w8BPky6i90DjfoZbZJKt3jkM0xjv9OuFPJxuvAErRODHtRamraV41OwwwxkZKd
	 hsHX8LfrH+VS27tVFh0JFIzc/loyla1EP1UIO0iz7sFW2zkJZfDlm4/mWxL9h54A0t
	 atqgIDPBjQ91j79odG3A5mI/LFhzPE7CVPYGmaNh9MtQPnbcwUa3dWq6CdqmUvPVSl
	 1DOMUwIIxWFLw==
From: Thomas Gleixner <tglx@kernel.org>
To: Chris Down <chris@chrisdown.name>, linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker
 <frederic@kernel.org>, kernel-team@meta.com
Subject: Re: [PATCH] timerfd: Support CLOCK_TAI
In-Reply-To: <abu8cG7g11DP9nkn@chrisdown.name>
References: <abuTTv9FC__H_8RC@chrisdown.name> <abu8cG7g11DP9nkn@chrisdown.name>
Date: Fri, 20 Mar 2026 18:36:10 +0100
Message-ID: <87tsuaiet1.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Mar 19 2026 at 17:05, Chris Down wrote:
>> Will this cause a silent API failure where the timer is never added to the
>> cancel list for CLOCK_TAI, meaning the timer won't be canceled during
>> administrative clock jumps?
>>
>> Additionally, if it were added, timerfd_clock_was_set and timerfd_canceled
>> hardcode the jump-detection check to ktime_mono_to_real(0). Does this miss
>> independent jumps in CLOCK_TAI caused by adjtimex(ADJ_TAI)?
>
> So, timerfd_setup_cancel() is currently restricted to CLOCK_REALTIME and 
> CLOCK_REALTIME_ALARM, so a CLOCK_TAI timerfd created by this patch will behave 
> like the other non-REALTIME timerfds here. The behaviour is that the flag is 
> accepted by timerfd_settime(), but no cancel on set tracking is armed and the 
> timer will not report ECANCELED on clock changes.

Which is wrong.

> So what Sashiko says does not block this patch, because the patch is only 
> lifting the timerfd_create() allowlist restriction. The underlying 
> hrtimer/k_clock paths already support basic CLOCK_TAI timerfds, which is what 
> this patch is enabling.

Your new friend Sashiko and me have to agree that we disagree.

> If we wanted TFD_TIMER_CANCEL_ON_SET support for CLOCK_TAI, that would need 
> separate work. As Sashiko also said, the current cancel detection is based on 
> ktime_mono_to_real(0) (that is, REALTIME movement) and would not be sufficient 
> for standalone TAI offset changes such as adjtimex(ADJ_TAI). So supporting 
> cancel on set for CLOCK_TAI is not just a matter of adding CLOCK_TAI to 
> timerfd_setup_cancel() and would require defining the desired semantics and 
> adding distinct change detection for TAI. That's a much bigger change and 
> discussion.

Q: What's the discusison required?

A: None. Because it's already well defined. 

Q: What's the big change?

A: Nothing. Because TAI changes are already propagated

Q: Did you actually look at the code?

A: No. You just paraphrased the output of an AI bot. Nice try.

> So let's leave this patch as is for now.

Correct. I moved it already into the not-for-merging bin and that's where
I'll leave it. I'm not merging half baked crap based on the lousiest
argument I've heard in a long time.

That said, I'm not afraid of AI itself, but of the humans using it the
wrong way.

Thanks,

        tglx
