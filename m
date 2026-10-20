Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.230.138
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792525566;
	b=L4xnGPU7hhLt0tfgqs+4qK34zweqbTdOVc+iNeU4kc0gx3IoSBmmWVzNZ3L9XKjK64mz
	 xq5kNIJxTypu9qF8YQvSPskj3fBd7NudSjWkroS46ALpexAZvrl00cNOaiY9aBlnh4n0v
	 vaFR5S7HPQUwDK4fw+f5eMHm9azYLlgSIvoGfQvmTPF+6WIdmc/BvISAcJJwPR+UTssNN
	 hGBBGzV5if3jZFEiWnsOwt+RTz57xKsvKfeoIT8SaQn8mzKKyPXFEyfmPJp4eaCybtFhJ
	 ngFf3wlZM/A0hATq0d7+Xi9NnYwIxhwRgcseV7G6GtDdskKlfHegyRPwU2fu2RzgRQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792525566;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=0Dz/HJwUNOagY1cibG3m6O3ofOzpUbQLthWmzopo71w=;
	b=myk+RNaUGh6FptypEuYxes0GJYqvkzhMLl3yKlkQyyLUmhT94l/MjlaXOvg9nzRXTiU5
	 XM4dVjo2udVrJJFQ7f69vYrRYIyASlh5BrXDYGjaGY8uCl3gPlnVYpHFtBZJGH3FSbWTx
	 zHvuo1uQO6JvhlQ5kPZlHr27Z7I3IzqRBeYf9cOu9sGzarJvJ5kPApV6cBdAVtqc8zRIQ
	 Brgu5VSOy9JpKBke+0GBmcKOnsAA6A38JdKhnvEc5pw780X0FQ4FQlehzmNErlsCcn0Xy
	 GT7wP39MXwHFBK8dFgt42D6NXsAIY+vrtjHZefvmr0zWVQ5fQGEDxNms6xyRhqhz9AQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=G7JjI2I0;
	arc=none smtp.remote-ip=74.125.230.138
Received: from mail-qv2-f10.google.com (mail-qv2-f10.google.com [74.125.230.138])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F26AA606A31A
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 Oct 2026 19:46:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F26AA606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=G7JjI2I0
Received: by mail-qv2-f10.google.com with SMTP id 6a1803df08f44-91b81cce44fso770096d6.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Oct 2026 12:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792525565; x=1793130365; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0Dz/HJwUNOagY1cibG3m6O3ofOzpUbQLthWmzopo71w=;
        b=G7JjI2I0kSRfhJwoviEIb0sARcyrU8OjLKEDoXBRv55kViEau98lD025falnDP+3rI
         gq/9X/JZqOCyRPWfN/lJ/yHd43Q0O+f2fVIlNfRfrPH1XkOiq9kuoa61q9kgcNkdukXi
         4sGashUYcnXqWYpAxNOL80HCvtlUCFr/cFT3A7VhuKwqc/HQXdQoskvQiCuzg6kHOzgg
         Aw+IIoldLSRPFpZdDvfyvzRYdGltJFIA0xsaZMjHYihZLxeR/zo+2rCbDxutv0RKuJ6A
         9+ha+EQeQ7ED3BPHPn63oe2XhiPDUElQs6qj3OhKRSGJKEkOOVB8D+UM6yLiCByihj5g
         FjLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792525565; x=1793130365;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0Dz/HJwUNOagY1cibG3m6O3ofOzpUbQLthWmzopo71w=;
        b=Qh3eyV6XDGMoZ6QqZ1E5/R1UFmoueS/Lk5PjqKEFjiOxoZrTTI/qGm5eq0BuTWusTN
         7NIeAXyVnFNWxw2jhgXn7/NOUaf7+a2Y3kq2skfBxqz7ZAfAaGBbHm0XxqIxOsl5LsXV
         CRk0hz1n9UXvn+XWmWCjaHb49WsZwLAweRYozycdY49zcVevrGyDSmRJuxntBiF2N7cS
         IHmLxsb/Qq5S1CMX7rq4DPXZAtKNQk5BqzCGbVoBPkNooANMZiys4AJK68rSwtFtoU5V
         KxPKfvG31tJ7Ges/MUXG48QBQ4CjxkBRXVabMIcEm7mbw/eHhQaUZ+8HeBIot4dYhscs
         LyxQ==
X-Gm-Message-State: AFq9FYJyEXXAWmWQdutbnDKkX4pcJ/E21IqNbSC7Ni4zbo3eRhYZ0wtG
	KSn/YqqJiJhGkdtRJnyexeChkX0Q5YUaEvBVBz3zZzptlRy6k0Mxs3Jt
X-Gm-Gg: AYBFou0UKfyX+Ko3GPP/fAY+fJm9AvZqcpS7hHJDbrPcmwkBXSMPEHC5AWxDEupBxvg
	a4OKzLUJbgiBuveHvHrLJPFWr27OA1vvuJ6HFR/YEQMVmlw+JXhyA8LR+iyB30UQ2oid2UICRiJ
	bMrRKJrQrVwdtzJWYjmcexbtcVZHj2MFHVCY1VHR3xK7WFWFCTxd1r//hff2D4APrYIE4JqMxCT
	FQUypiQcZtkpBfKG8IfiR52ZVZYE989jQ2A8kvrbrVYOrkTzkA0C70NWcArrettvSQ8Thdc3yfQ
	CxpyNV604cHn4uWmHdIekl8yBjVetoOn9hY0Z3TmCTxk7WKA5kHZ+TzY1m6VVAxWOi0nO+zvpNm
	KGMwQ7hIR72ASez9Hz7sq7059UiTBYUZxILGl3YLHFG9Cj2XWfDu2ajytQLuLMWrQCNV89HqlQ3
	/Fi7AM3SyA4TUm+nP2zRy7ENaOABlOxs/beltbjcEO480fNK/7g3BlqMXRoUmIh5e1dLEK5NYAh
	GUqDRU=
X-Received: by 2002:a05:6214:2489:b0:917:1f8f:6d3a with SMTP id 6a1803df08f44-91bdf02224dmr210632286d6.17.1792525564731;
        Tue, 20 Oct 2026 12:46:04 -0700 (PDT)
Received: from Fujo.localdomain ([142.188.41.221])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c10b71583sm6336516d6.15.2026.10.20.12.46.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 12:46:04 -0700 (PDT)
From: fujo <hooyan2024@gmail.com>
To: Oleg Nesterov <oleg@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
 linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH v3] selftests/pidfd: wait for POLLHUP before reading exit info
Date: Tue, 20 Oct 2026 15:45:18 -0400
Message-ID: <179252551833.59967.6484153471898928809@gmail.com>
In-Reply-To: <atc59R5-oBnyOIb8@redhat.com>
References: <20261017054356.7874-1-hooyan2024@gmail.com>
 <179234213014.649.6368924662349703640@gmail.com>
 <atc59R5-oBnyOIb8@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hi Oleg,

> Confused... V3 still changes the 1st poll(&pfd, 1, 0) to use POLLHUP?

You are right, and I'm sorry for the noise.  I fixed the source but
amended the commit without staging the fix, so the v3 patch still
carried the old hunk.  That was my mistake and it wasted your time.

v4 no longer touches that poll at all; only the polls that are followed
by PIDFD_GET_INFO wait for POLLHUP (and check POLLHUP in revents).  With
the corrected tree the tests pass ten consecutive runs.

Thanks for catching this,
fujo
