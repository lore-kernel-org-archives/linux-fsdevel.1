Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 868FB37BE9E
	for <linux-fsdevel@vger.kernel.org>; Fri, 28 Aug 2026 17:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787938003; cv=none; b=uRRgLlFtkSM8kV3yk9Ay81v+0qYAXeuYq2XsVhpWOhwb8vb3o/V90sXXo670bFPVxnke1MALTphyN2N0DpvA4/R+6l6vwxjkuSaBXp0Xr7C2wBwJ5fFf9chtioLwGWxu6oX+uqLTtgr8y7y9ct/AGiB3ObuWHNslpLv7hkTpvII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787938003; c=relaxed/simple;
	bh=O7aH7jNv5XACVYwfexRjkMyDCwV8m7wDLIeuqLxSpIM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=taPZaGM/XJ5fvvmrn/ru1d3nExPeXpuflrQBOEOq1PkBZiR6BBhnEMScCyMOTRbPcfB+WkfLwGly4jLMduQNiYzJ/VUqGwoT3WdbDECL0xtuP80Wumk455Kof+kUbz5fskAthC8aFDxuiIQJVDZAe6CXAUSpPubjwQLlSBkSMfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=L6nN+lGX; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="L6nN+lGX"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c1c52d920b8so156685766b.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 28 Aug 2026 10:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1787938000; x=1788542800; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=y1RgJgjYZ6layd6nj/pPqRD5/ufb+nrNE0c26oBEfgY=;
        b=L6nN+lGXYoIzJxfPacY9r3PKGvL0zpIwuu3MeK1uNJ5OSfXTEFwj8/TqRvMBJ6tCIW
         vkpHY7ui5mGmVha7tyDWEyhSxXRAU3ntmiP5RiLNEUGXx4L9QQWZy1MqZ6qALX5yas9o
         vDqPGRfzbjoruEGdYSdby+yJZaYnWetUWbaHk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787938000; x=1788542800;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=y1RgJgjYZ6layd6nj/pPqRD5/ufb+nrNE0c26oBEfgY=;
        b=QU5iFtIL4cVvvsTxoEWl80bZt+M2EzGegVFRIWW6Wmrwn+MEj2pgQIGdPDyZQO1nbi
         cRFn0e2PbRnh4IvpeJ8mhh5RB6vClpaetUG0v2XJm2wWItqo3l4UtldQ1wxhqHYlTL+N
         CzMWHTpxfgiuXaoHh67kaGcxUaRg+TdbNMPsTAp4O1PpHnuqjG479vV0sGPFEm2iWepb
         JE9pvAEKAj9DKUdeSnlKECf70xBiyZFSk5C1ywoK7D9Rsw5kWwVOB4mRoMq5gqm5NCTj
         4vmh/RjTc51jy3cM2TzO/QCoMASvsSr9D+kbC8nFBVJYBXxjEaBCNLKRiJh1lGOKYZ8z
         PtuQ==
X-Forwarded-Encrypted: i=1; AHgh+RrpRpw42fCpdX6WHc+oDaE4PY8r6LQu/TzdnJ8Zv23F+8D1rUbjt3kIKIlRsYTt9G37t6E4IVU9bBh3NXIi@vger.kernel.org
X-Gm-Message-State: AFuF++le1QnqpBzfFdEA+4rUdHQO2PdofGGlvlDvN9I0E2worVTElzVZ
	rM9n0bn390NXfMvLA65zptaxzFUlyDjgK4uPCViTWnLOK4k3eD/tqveCqZaY0SKT80cZQW+ftkY
	/uo8xyhc=
X-Gm-Gg: AR+sD12xbBTqKWWVo8v3m/gJ7BIZO/eObnOuI5lgbekgTycKpNg4aMGXILr1FjJ8Y3Q
	akxVU7oLn6evkeZRm2YVLSKi4F3AMMxQ+VtVQP9C1qtmCShXmR3iUdZ0I6FMeqVYuHrwF4X50DR
	LUFUY5Q1JS7G2CgvnWYiVnLp3GksruJ19qpE8aUTe5mnlyKaxV5y4r89qsSQRHfaPFa1j/ATnz3
	tcfC1TpW59ZPpimteV5SKvX+T4I6PVSwHXraW4aDzYk4NXwsj90Dh5SMZczOhWrkFuOyuCxh1r9
	eK+IO+BwVZjISNlMMBMCTgBLVIRW4CHj54Ul0Xs2210MV0MHsWM0dJ40QXqOJgT5MhNxB5TomyC
	mpQS5xMZn1YcySfWltUqSxXgkFlUZrwpPNaoXLpUljEyoaqaPxQKG6pn57tlEC4qbyy7JHCccl8
	t5GhhTae+/5Jq+if12jnLFvEnYI5ErS8iz5qFdzbwF3ry+lCj/z3J3DybCkkqcxfzWonvl0mD99
	yO/MLU54OIuQrgVwu8VXMJI87S1RD6lBPVOsXOMQO/RgYMc
X-Received: by 2002:a17:907:3e20:b0:c24:d914:6d64 with SMTP id a640c23a62f3a-c255720d399mr598485366b.23.1787937999621;
        Fri, 28 Aug 2026 10:26:39 -0700 (PDT)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com. [209.85.218.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c255f1fb87bsm104599966b.47.2026.08.28.10.26.38
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Aug 2026 10:26:39 -0700 (PDT)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-c250c6a6a6eso167535566b.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 28 Aug 2026 10:26:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RrRDDo+/TafbWIrjBMbmEuSJUDxUQ7s4LcuIiIew/P7wp+pSq3BRH2JBzW08I1vth0cFSxjKRKAPhGuSFlg@vger.kernel.org
X-Received: by 2002:a17:907:cd0e:b0:c25:2fb9:b897 with SMTP id
 a640c23a62f3a-c2557164d7fmr623783166b.18.1787937998688; Fri, 28 Aug 2026
 10:26:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <apG8g-5krNRUFUuD@casper.infradead.org> <CAHk-=wiY22BnQkAMMc8-h6xaRksvVAbASpg=pj+=kVaXXQYo6w@mail.gmail.com>
 <apHC_mHJ3wsJPEgy@casper.infradead.org>
In-Reply-To: <apHC_mHJ3wsJPEgy@casper.infradead.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 28 Aug 2026 10:26:22 -0700
X-Gmail-Original-Message-ID: <CAHk-=wimz+APb9hGEry+vHDLB5D7WZvNGWU89HjGw7wH15KGHg@mail.gmail.com>
X-Gm-Features: AcwNN1W_Djqrb4dbrNf2FnJjSle4SvoCwveEoSjB4FMfvcDCroxNv-63LlnlaaQ
Message-ID: <CAHk-=wimz+APb9hGEry+vHDLB5D7WZvNGWU89HjGw7wH15KGHg@mail.gmail.com>
Subject: Re: [GIT PULL] Remove dependencies on pagemap.h
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 28 Aug 2026 at 10:18, Matthew Wilcox <willy@infradead.org> wrote:
>
> OK.  I thought you liked this kind of churn stuff at the end of the window,
> rather than having it create random unnecesary conflicts throughout the
> development cycle.  Have you changed your mind on that?

I like things like automated churn at the end - IF I HAVE BEEN TOLD
ABOUT AHEAD OF TIME and know to expect it, and people have said "this
is scripted stuff that can cause conflicts, so I'd suggest we do it
just after rc1 when all the big stuff is merged".

But I absolutely do *NOT* want to see a random pull that is broken in
other ways popping up on the Friday before the merge window closes
that has never been in linux-next and has never been explicitly talked
about with me beforehand.

One is planned. The other is just rushed garbage and badly executed.

See the difference?  You should - because it's not a very subtle one.

                   Linus
