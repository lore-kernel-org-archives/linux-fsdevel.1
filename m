Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B867737BE9F
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Mar 2026 02:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774492182; cv=pass; b=fGUP5u/J41II+nDWk051Kar2fIAGV/pxSq8qOPTy1tNhcQOU5OPMJqcmk7MZjftLfjXjsvxNzMNjZdT7/ZVwrdMefgPbjD/CCMkmYo8mihGljvDVtyNoAP+xM2J8RbTqSIfzA3u7gVK9baAOgxSjoK2eiABNtKecfGgTbJll+Kk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774492182; c=relaxed/simple;
	bh=z4Rn3gNatuHl/9qSVwptNOj7bYliPOcWtNmCwZiRk8o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kYyWzadAF34hz7BIkeTTqGJbca932jPMx4rdIUMStlCrUWM0vEWjr7xXjmb0+4QxkhYHb/oZ8CHAr7wCMqFgegQWtrjL9NgZvBbdyx8tb1kxAavp7VbEwcXKfWV5oLsHCF/jCr8gojN+pkhur4DyyqsTB/K5CyyqKWUIF3up2gM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Enx7LrGJ; arc=pass smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Enx7LrGJ"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5a10d130b37so398800e87.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Mar 2026 19:29:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774492179; cv=none;
        d=google.com; s=arc-20240605;
        b=H6TrriltyhzM1/dp81VTGA0/m7M/CZnRyjqAjBLRZ4gZCytu8ZpBd7zs/f9p4xOiGC
         dNvWVX5zFUfFN8HLNpag/OjZLpYrmYlDAA4eShQ/5yPhlhw7EduF+g4r9N9AxHhA8go7
         cjiTExgUIahuuTI/VryZwtwn/MAE0G3W/vMq0pE702qy7yUmgi4x5JkuHhoTiecdISQB
         ED26YezppvE7ptVzyYvJuV14IqcwuQxkIyrsjnxGqAYg1GJYiNhd5npW71h4N7bnGBo9
         cIUfE1lV1RWKZMy+sVT6thituBv8e6W6Wd4WukfD8PLBPz6KEo28eOe5h075835ts6K7
         CP/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=z4Rn3gNatuHl/9qSVwptNOj7bYliPOcWtNmCwZiRk8o=;
        fh=k0q06gB77VD872aer3/McfqnZKl6MQqfGP/1/odp1yc=;
        b=f3DZjHk4VqeT7zH6VYmIhxMgSrCu9INj5yfNc//lq7gY2xLCv3tZvV3emLS7LpsPh0
         xTCxqm0LZjB5cgf+/tLgamW08QN6qsiCatc4gXncmOCChRq6CviFYYvUxCv1SmEVoSPE
         vPUf3Q4m6ex2qo4o4wknSXJ1MKjuMUjRbeO1w5e30AHFDdtWtMyiQrufD9LsX+r7+bwB
         OdoUVRlwp6w/54ELVa8gbkk8A0CIDrf1djYVzeYM7q5BJPAsNhCUiyfiG6aIY7cDxhOu
         0zIEykK+/NGR4w2zABkYotbghwf0/LwkCdLxCMsomn0WXob1+z0Us4PQkGl1ZMBxva/Q
         amzw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774492179; x=1775096979; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=z4Rn3gNatuHl/9qSVwptNOj7bYliPOcWtNmCwZiRk8o=;
        b=Enx7LrGJupQYN5lCl8cfH0Hde9x1dovzlhUv/PrmUfXCbrLOF+zHRjQvV9vXomVqXQ
         sWqasSFnoScj1kY/7j0Kf7HfoH2zxWr9Y9Jf8aNi4a/9WtgYSHKL4TooDxq40YpxHHIm
         zsNO7BY1smqKGKiPwqVOU6cjyqrUsLsVpLoIf9pQiifxlZqVGBxIFbO4crd7eBjAStwj
         afCjsA9ez7t1RO3jDZ5J6dWUOCGsJXlfIPlBRzwXhKV1asi0GUVxg9Kxl9leD6WB+7cz
         lfj4ibmgR1/QvhU4Ia7wTFY73b7lW6keMe4y9CgOY3YlZlwdKPoFL3vnas+w+r7cnrd6
         dH3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774492179; x=1775096979;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z4Rn3gNatuHl/9qSVwptNOj7bYliPOcWtNmCwZiRk8o=;
        b=dL/KQ0/6sCVeOth0poO9IKWsh2bcHy+UyDRlZe2YU73dxyeteSt6zMMuccDRx0dLRL
         +0Vs/liJ7HB8Dy0i+kRKNCjN3ocgbBzM9TsLJYp/Bz0Xovh22/0ICjbDewX/dIhpIimq
         q0eev5YB7JAxCN3HUBkTFg1cpquETRMBE0tLYaEaRf0V/DELUvqSc5TrOyHkscbGYyyJ
         G9XAVRq4opcSuwZZ//qq4vG7nfJCKSsWLJRYCbMbwLJn9fqmHiHItjNZUo6ljptyiz7p
         XmYXpyFIkAwYRnTYolKmCMStR12ZrI3TDlkcyO2dK+ITYqxZrZPc6W/Z+oy1o/8QSOwc
         uKnA==
X-Gm-Message-State: AOJu0YzB2TMmTxXR7z8oRJxqSyDAI9j665U7ULpixytEeb9SpKR/ApID
	9TxSmLLYIuvcQWfqulJgqcmC6aZ/vS5zQ2uQlx31IhtLpSVC78o8pHEp1ecGk+ra86SiqjmznJE
	CSFi2+mrDYXjCvF/3iN8JK3K0MIVEtf0=
X-Gm-Gg: ATEYQzyRfC4TW6OehS5CVCNvxN9YTqZ96JFPGJglObVs+W8NGR+qEm/kX44CyNiNzcY
	aEP1Be0Y3VIzv7i8/W9AqrwLDEi6Ng1+dfyABbiPocU5GKjAp8FzfPrMxB+gQ8T/A2UFvmVVziF
	BESezcni7/9rSIjE2yWtJtbWAUha6NtzGxY8IUDjSibPuvrHYolqnNNh3Mm4eRsKDjNiG/fCo2t
	rgFv2zPPGmPIlKK7Owd93EjdEnbC0QcX9o9rTy4T1fbOFIB+TPI6tudzYhPMSDH04oz/l1ZmOi0
	R1zF
X-Received: by 2002:a05:6512:1286:b0:5a1:44d7:1fae with SMTP id
 2adb3069b0e04-5a29b4f8fd2mr2449829e87.7.1774492178666; Wed, 25 Mar 2026
 19:29:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOx6djP4hb-Cd1Zk07SNfFfLc8irjNmbVqq+58h1Whz+h1wSFA@mail.gmail.com>
 <befb1cd7-f709-4e46-b08f-9c2579b10fd6@hogyros.de>
In-Reply-To: <befb1cd7-f709-4e46-b08f-9c2579b10fd6@hogyros.de>
From: Sean Smith <defendthedisabled@gmail.com>
Date: Wed, 25 Mar 2026 21:29:27 -0500
X-Gm-Features: AQROBzAQWuoiwj5NVrb0IEs5rZjhQDz2eA9mdIKzDHDnBj0mRJSEFKwDanpDi9I
Message-ID: <CAOx6djOJGstn-GHX_wgqOVQ6FKn7O=X-ARSi5=711JwXoQRZXA@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_=5BRFC=5D_Proposal=3A_provenance=5Ftime_=28ptime=29_=E2=80=94_a_se?=
	=?UTF-8?Q?ttable_timestamp_for_cross=2Dfilesystem_migration?=
To: Simon Richter <Simon.Richter@hogyros.de>
Cc: linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, tytso@mit.edu, 
	dsterba@suse.com, david@fromorbit.com, brauner@kernel.org, 
	osandov@osandov.com
Content-Type: text/plain; charset="UTF-8"

Setting an xattr user.provenance_time was a solution my AI agents
and I arrived at for meeting my immediate Windows to Linux
migration needs. The idea to submit this ptime proposal was to
help the Linux kernel maintainers better understand the types of
problems that users like me encounter when switching to Linux.

Users like me are working with AI to solve previously neglected,
and untenable problems. I believe I am amongst the first of a wave of
disruptive projects that is going to hit many industries quite hard.

Users like me are unprecedented and working on unprecedented projects.
I think of my proposal being a bit of a heads-up to the Linux maintainers.
To help you plan for what's coming by understanding the vanguard of users
that are now arriving.

My intent with the proposal was to highlight:

1. The friction I encountered in Windows made the switch to Linux
*necessary*.

2. The friction in migrating to Linux can be reduced with simple,
long-overdue changes.

3. While ptime might not be effective proof of a files provenance in terms
of forensic computing, it is metadata that is critical to effective human
and agentic workflows.

Additionally, a sworn affidavit of authenticity is one way to assert the
date created is accurate file provenance. If the system administrator
knows the integrity of the metadata is sound, then they can attest
to that under oath. But if that metadata is destroyed, there is
nothing to attest to. The date created metadata can also be corroborated
by third parties. A plan beneficiary who records a phone call with
their insurer, and the insurer representative enters call notes into
a database. It's an event that 'happened'. With enough third-party data points
verifying a private dataset, the metadata becomes something a reasonable
person should believe to be accurate.

My point isn't to argue rules of evidence or debate how AI deep fakes
will require courts to exercise enhanced scrutiny. It's to illustrate
that the date created metadata has substantive value to legal work.
Additionally, that legal work is going to become an increasingly agentic
and pro se process that can supply substantive value to society by
enabling the under-served to access justice through an open-source
stack.

My proposal for provenance_time is more about reducing friction in migrating
to Linux and optimizing real-world workflows for humans and agents.

I concede that using xattr to add ptime will be effective, but it does
introduce operational inefficiencies and overhead. Overhead that I think
it worthwhile to be mindful of. Having every users AI agents coding up
an xattr fix for an obvious problem is a lot of wasted tokens and
human attention.

Sincerely,
Sean Smith
DefendTheDisabled.org
