Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB8347CC97;
	Thu,  2 Jul 2026 11:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782993081; cv=none; b=SGJnN2Ep6CrEASbGxPeyWCENLpK7fW/2zVEUgLaAUKp5vpz4tSqu7dO+KBNLeiwtARUmsS9U7uKb5x3lgP3NyuyqOgSe+TM512T83YJq/dsUHqVt2PPlWMEubzDsjqXGxJ36ekKLYHH7C7CQOdFMYQc+TShu0Z0bL8edz4ttXHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782993081; c=relaxed/simple;
	bh=o1Rh4oYb0269rCu+uez8gvHa8RCE2onRyCpbquaqQbk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K/3zwC3b5qUDOaRfwH3wqfkP4otVCpqN6w5Qv/PZjD9p4d9yGn5FU5cCpGEdVkYWXCEVFmD1cO2h7k+Hn1GGhdjYEAj1NfcXG5TyYvaRhfuGtEALyBYQ0oaOi6dGJ1EpC/qfTwoAq0Q9ar1vR1RPnqdQsxAqvS8p0X6iW1ZSIRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fdU6LcVj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fdU6LcVj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E92771F000E9;
	Thu,  2 Jul 2026 11:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782993076;
	bh=HE/Q9Eq1voDEKGJinYVNwOuV8PPFWOwtUYtxlvplJbU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=fdU6LcVj6HHXQVwa7NPNVzK9cfWw+Or+X7w2mw+FihFw+DBbsGxH4rRBiXivaqgmp
	 /e/G3xEss5OArYF7jJyiifPfJH33qcBlUMW0TiMYF7cq/xa0YxzoV/zEhQRRbxEBnL
	 sc6p5wHggxPEbqVzz/ptDtnMiNWE8uy87472Ad31NYaCX0xvxfA6cCs7wgEdbQ3tU7
	 27s0DQG8WHq9Xo55YC6+U3cLC248Ui8HXHLWccDiGw2qLvj1CoGp4h28+06dKTF6O0
	 l+qdUwi93yltZSJDR3wE4kTxEUMZZT9BT0hHPsQbFIsfszgjxsAbwXWrQhaEyLXfqI
	 raPYZVO/Vu98w==
Message-ID: <54d3a698-a275-488e-ad36-ef423db30f70@kernel.org>
Date: Thu, 2 Jul 2026 13:51:10 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] coding-assistants: simplify attribution
To: Lorenzo Stoakes <ljs@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Jonathan Corbet <corbet@lwn.net>, Jens Axboe <axboe@kernel.dk>,
 Jeff Layton <jlayton@kernel.org>, Vlastimil Babka <vbabka@kernel.org>,
 workflows@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20260701-work-coding-assistants-v1-1-a20a94d1d606@kernel.org>
 <5e7b9d23-4291-48fb-bdc6-47db82d33c80@kernel.org>
 <20260702-seekrank-stilrichtung-mitentscheiden-69a64ee097ec@brauner>
 <1f29f48d-b9ff-4de2-a392-dc05781728be@kernel.org> <akYz2aMIco1fbD-t@lucifer>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <akYz2aMIco1fbD-t@lucifer>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/2/26 12:04, Lorenzo Stoakes wrote:
> (thanks for the cc-!)
> 
> On Thu, Jul 02, 2026 at 09:46:37AM +0200, David Hildenbrand (Arm) wrote:
>> On 7/2/26 09:27, Christian Brauner wrote:
>>>
>>> I think we should just drop any attribution as a general kernel-wide
>>> rule and let subsystems require them as needed. Then you can have all
>>> the complexity in mm for this that you think is needed for your
>>> workflow to function. This is precisely what the subsystem profiles are
>>> for. So maybe just add:
> 
> A single comment is complexity?

I think Christian meant more elaborate rules. More than just "If you used LLMs,
disclose how you used them."

>>
>> I'm not really sure if having (more?) subsystem-specific tags is the way to go.
>> (below)
>>
>> So either we find a very simple, kernel-wide rule for such tags, or we drop them
>> entirely.
> 
> Yup I couldn't disagree more with Christian here, the whole thing feels like
> trying to 'wish away' the AI issue, and now punting off to subsystem
> maintainers...
> 
> Subsystems impact each other. Right now I'm writing a series that changes driver
> code so we can enforce some sanity in mm APIs.
> 
> I've had to interact with fs code quite a bit that uses mm logic.
> 
> It's all interconnected, and one subsystem let's say going with 'let it all in'
> say, impacts another.
> 
> Yes some people lie about it, but having the guidelines only STRENGTHENS our
> position on that, and I've seen that in practice.
> 
> So yeah, sorry, I think it's beyond silly to push back on requesting somebody
> disclose how much of a patch/series was AI generated.
> 
> And [0] already essentially says people NEED to do this now. But that doc has
> been rather downplayed unfortunately I think.

[...]

>> I agree on the "enforce" aspect. It's impossible, but it's still easy to catch
>> people using AI irresponsibly today ... and that's what we care about. Not
>> people that know what they are doing using AI responsibly.
> 
> For me it's about empowering maintainers to push back.

Right, but I suspect maintainers do have this power already, it's just not
exercised that often on obvious AI slop yet.

> 
>>
>>>
>>> If the information is mostly useful during review then I still would
>>> question why it has to end up in our git logs. It's completely
>>> irrelevant information imho.
>>
>> Fully agreed. In the tree it's irrelevant.
> 
> Not sure about that, if it turns out AI-generated patches are causing 95% more
> bugs say that's pretty useful information no?

Well

a) You don't know how much AI was used. In particular, it could just slip in as
the submitter tries to untangle some of the mess the AI created (so not AI's
fault). Or the submitter just used it to write+translate the patch description.
Really, the tag itself doesn't tell you much as it stands, which is the biggest
problem I am having with it.

b) You don't catch all the cases where people didn't use the tag.

> 
> Or if you find that a patch somebody sent from another subsystem that has a
> lassez faire approach to AI slop completely breaks you in some subtle way, isn't
> it easier to push for a revert if you see it's LLM-generated?

The information would have to be had from the linked mailing list posting.

Given that some subsystems already started suppressing the tags when applying
patches, that doesn't really help ... :/

> 
> And is it really that egregious to include a tag? You can ignore it if you don't
> care.

I hate the current tags as they are. The question I am asking myself: assume we
stop using the Assisted-by for LLM stuff. What to do with the other tools? Why
are LLMs suddenly no longer a tool to mention there.

-- 
Cheers,

David
