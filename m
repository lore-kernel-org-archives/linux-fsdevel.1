Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2855139A7E0
	for <linux-fsdevel@vger.kernel.org>; Thu, 10 Sep 2026 04:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789013657; cv=pass; b=Dq2SJa352ZuFrG7DsWrG8/Pnax+Yk5qr/0MZFUX5e9CNLe0M3xqcPtTYZhMjIU/1HgQF+2RfGhT5uyVcRMxNTDCMYVgJuXsHf3r5S66IW9FevZgelzXLMayetjvb6k42eZZDZc3IJSrKnhjDohF7S9TRy3FVBRaRNnBDvf7+XDE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789013657; c=relaxed/simple;
	bh=PfbASwnYRFDckXUlVC/ifoAWFmyWh3yvGwIK5j4t4Fo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KQ39q2KppcGVzNWfc90Ji5+is4ZBgQsJz3GnxIhHy/mlVjNVgnUU/SVbAyN7rW8FxRbqFupUxnPhf708P9M4ova7vQ8k+vyyt26hJwHGJ6+CzJP+oJ+rK9gqKmPXakU12FxZJCiap/yvvlnw/Rkv/C1w3pqq6pHMa8rTYzULb9g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dzRMhbT/; arc=pass smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dzRMhbT/"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-395cf2535acso564438a91.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 09 Sep 2026 21:14:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789013655; cv=none;
        d=google.com; s=arc-20260327;
        b=D+ny7n/d/ZmkJf4eqPQU9/C0R85hiTZXleqAxhm8hGPOSCmkRfV9hl9cgPnc2+btee
         +iSq9RxMZf+PdVNytMkgbIYHFn7vDyaXLjUFsyFBj6ROecQ61b34GzwwNy7jugH+VomP
         kTmip0uaWMWtpxlyU9CIOx6LA1+goNDPGbyiyAQm8ebMAA2ShRPh9eNrSZwCkFAl7Sao
         1hNXyI8nfW51+L+kQH1UzFp/nCJgo3R5OzP8kc4QG06K9RR04Qq4a3YWLzRWcFSJohsy
         UwV2GaCyxLxpUzKvY7akNmRVTpk0sIqqM1Pb3NDVoruFHVfdK+EXh9kFtZiFpqwRdpPh
         bBPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PfbASwnYRFDckXUlVC/ifoAWFmyWh3yvGwIK5j4t4Fo=;
        fh=BfqBjFiGYGs9pWtPx71qRrE7g2t07IyG/SxpgAdjIno=;
        b=K+0AG7wRUPtmRjCLq6byYSXCKjvL8yyQPnzwPMml69Fn0xMZblvDR9r3BpVhoziPBd
         JQXEJ3PHzzAUpgjmbe8FwXCa3bd2gjfbpfYAtF7qeM4Kxndh9FeyzsGWk3wWkNQDwEXL
         TCfqZA+UxmyDaSOP/KqUEKAGDWWNDybqvZxc5jckNu3uW/UmybtlmD/W+lb93Xe7dQDr
         qQlY380lNlwS2caOTPcsOVv2Ofym6lOzkz3+pGLD2OIRUBrm+EHXKcT5oniP4OKNGCXp
         MSgePjkyrA1zyrddoFnF+vwwEvKQPkScwvZYRtCzRyHEOLcXPNNqKrs36YUFucT6x8KN
         3jAA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789013655; x=1789618455; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PfbASwnYRFDckXUlVC/ifoAWFmyWh3yvGwIK5j4t4Fo=;
        b=dzRMhbT/4WSBdYt4p+UNMBCgWiHNmOfmnCh/4EzpwuoNyUEKo5mAHVh1yeMjVHO6FI
         bP/muVJOLbEMT+x6LTLb6HJk7lbhlmandyGa98XVuB+QH9wpZxFMQyheLE3Ua4/2MaU1
         gqIKZxtBbVYAmywMp0QG1+gyN9QZaGEU0+drhCmP4XkMc929kFvR5fPWH/+BEhHEuhAL
         bMgr8D/YdfpqFCCAxqWQCfk8UwWMNsHduIrCzBmxghxN6/Dnh5AFzNoxvgK0bHOc4U+M
         qau5XH+uSy29Zolnjmj+63GCrsyEtVEq1cmpBrLp4HH1CN6KQs8du/qQJ/dI8+g+5hu8
         APTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789013655; x=1789618455;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PfbASwnYRFDckXUlVC/ifoAWFmyWh3yvGwIK5j4t4Fo=;
        b=hUVITDKO+CNaGS5zgm47ZKMNjQ0TcmC8tjI4e0RrVh+OuTPSmAsh9ky6ttZcfnJeuC
         J0rVVVpFzYjUX0FRuFIn1vPShndSiZXUjeUV/2Afc003q0IX7lE/eYLskCK5il2B+Mw8
         vG/m9a9VuU8PAAxKLDUpL5vMO8GI1NYzJ6ZiA1BcXUWBDKPFLJZ7Ux4DKA78t5muAPgv
         4vGm5wQhcxcV45f5Ze1kq24YnuoxgGHb0VRXrBmxIuAB0LBkbWcWfj/ahNdRkKOf0Zwo
         cjXUvD1c7gTlfZ8lhTqhL3hfgEGt3MsGxRo8x+HX22qOXmujequ61JxMkS/O0GxK1MDi
         RtHw==
X-Forwarded-Encrypted: i=1; AKwUvByYFEUchQcRjqznkut9PzwPd3/4GTLgk/yrNyHv4Yn604qluHETqTvAZJORnq+MtIE/BwGn7b6LAFG5NlKb@vger.kernel.org
X-Gm-Message-State: AFuF++kgQeAizlLeBxKVewgMGBWzojvhCDrhUNd6u6hB5ApS3tPVp7Zb
	qyIqoxLBS4dd9vbEYXRrVp5Hky8Ccd49tCTHRIG6najooRwgsFguK4Du8YyOgsS8g6oB1Sjv9YP
	na3cQxfC89Elo8eFe4dkC13in4/au7PdhyFia/UG3
X-Gm-Gg: AYBFou3Pb2NqsfXJ/fjmiwwXIqBt+4dQrcz9VcY1g+dCoQqoIIYuNDyNY0nMfndRMKe
	a4w4xhRZvqRHsVKhs1jzDnZ0W588kkVL5NI5WYBqc0FQ+0ve5lqH4bmUckdEL/hkwjvz+kp/WFw
	bFikWjPGs0lJKu5Vk2SgfYngozyrXd1EWo8dBdFzTdwNMZ403UXWIXecijUxpfnJmposFsMGwk6
	tiKdtAvX9mnZos7q1fHledTEHrOmJ6rDQ6GDWfu3kv9Sgjxs3+hzn0Wwv8V5cq8kiOcLtRiv0u3
	wZVKr2nEegsfTq+0bD1LM6HUKW4U02MKU4AA8n7ZmKU8JC3Ai/h1cT9kaCUzdIw9n7R74mH6zvi
	WNJ0yn7+n80pRQmI3j9WLO5VHDMpYCnaCDDQ9wy0k4QQ9S1MvjNcbVpDAYpYauHHZRLLN0djqzM
	a92GMMNODmlMQvsrNBqWVZ/sFX
X-Received: by 2002:a17:90a:fc4f:b0:396:669c:b5f6 with SMTP id
 98e67ed59e1d1-39d7796cf16mr3552487a91.12.1789013654775; Wed, 09 Sep 2026
 21:14:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260909-work-unix-passpidfd-v2-0-7bd342abb2d1@kernel.org> <20260909-work-unix-passpidfd-v2-1-7bd342abb2d1@kernel.org>
In-Reply-To: <20260909-work-unix-passpidfd-v2-1-7bd342abb2d1@kernel.org>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 9 Sep 2026 21:14:02 -0700
X-Gm-Features: AcwNN1U7qcy0Xgw28VWEZVf5s3od5zIgdwEciEhER1kE6b7z6Yof-RR_xDF3wvU
Message-ID: <CAAVpQUBC0zZqv5iECj4YvE=oA2hWR1kbxiG6zOBBNkaALwQXEg@mail.gmail.com>
Subject: Re: [PATCH v2 01/10] pid: add helpers to operate on a struct pid array
To: Christian Brauner <brauner@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	Alexander Mikhalitsyn <alexander@mihalicyn.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 9, 2026 at 3:43=E2=80=AFAM Christian Brauner <brauner@kernel.or=
g> wrote:
>
> We're about to extend af_unix sockets and coredump code with the ability
> to hand out thread-specific pidfds. Add a few simple helpers that allow
> to operate on multiple struct pids up to PIDTYPE_MAX with automatic
> bounds checking.
>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
