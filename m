Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC4AE374A15
	for <linux-fsdevel@vger.kernel.org>; Thu,  8 Oct 2026 05:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791435832; cv=pass; b=IfQgt4Vo1WDVyQluZDx4j4naxvmi3EcV00QEYfxRvvq6sn9flECbr/o39IUOt9YgKxI/x7EAukAx9YsiryDVTheZzzt5yt8LaU8RDdp2HJqxo1SPREhifMPq1nD62zsrKAP4XccvBe0sD8AF95crS5ZJP86uYrc9flkR1LWq5n4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791435832; c=relaxed/simple;
	bh=GjoeoU74ZYSuGHxDYSGRd9MIPo/RtdO0E0uOpCYv/0Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=inSJDGoVJgOWVPB2+vuDqNZjryuLkhdHJatL7ympFnqFrXjAo1SsEoIdbNB9QfGnb6L6aOESRMTDT2knnOLK+Q6RuDlGrXorxnXPzIUnlV419waOFM2iSa6y0AGeHgYNCu3YAyFUkNKBEqqGsPy8HUU3GRWnLwQ742B2yXJNJYE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UIKCFgt4; arc=pass smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UIKCFgt4"
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-33bf40b0c8bso1300180eec.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 07 Oct 2026 22:03:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791435831; cv=none;
        d=google.com; s=arc-20260327;
        b=TWNWfE6kvJKzfD8adAAF6wx/BU+/MPQDQy4duvvpGUZ5/k4prljGqrsxRLWE5BJW2e
         +9E990zP6EB6BhzmFtyiUZn+GA07CAsNzjY4iQRdyLxJBaN/ceH+ECYvCD4+J5rfI111
         QqhxcvQvNwxYrO0GChOt4YJClPWP4zrCJiLGcHLWWIyvOesAkvCEQhoRN3MN7xCbPt86
         L6oHgnLF26OziI4Tra6fpSLb7rOH3LB3HO1iuwjMASse8mmlhAcrMObdWSqsIf0EiFEw
         4cgUlaaaFwtehgFTWu3Go7rt/0v2j6Y7VtFsifbw2wGDMyYEoDWtU+CTbfJq2B7NwswM
         DFAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GjoeoU74ZYSuGHxDYSGRd9MIPo/RtdO0E0uOpCYv/0Q=;
        fh=4bsmruq51VAJE6tC11HngzLLlLoFjoWADA/r+PY0OZU=;
        b=ktfQ8aayOGEF1Poebqt8U8Ef28BPJKEsYAr59n67iZ95lSLvMk7cOHm7Jvmje95qDR
         ENs89D6AJ436fgHxv7tZuPtSj5Rl2y1YcmuopNgxmAhRR5Au4qIecfMW2CEA9QslF7hT
         o5RcNcJfdBlFN4NgNSrlaJXWvvVdEcEKoK5OIpCwQps6Dni1jcTtOHULaoKVLGxco8LR
         3/MSj7gU9oRy7SQfbcGIs55j+p1bDAffY6vxe+nSbh3PWyoNqveVFnHA69Hrswi7M5QQ
         n3I6lnXu3DEHcyvP5AoQMhetfPgB/ueYmxRAIDku6aZXYGbWHN5tDrb48DKMxPWXbCG7
         ijGw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791435831; x=1792040631; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GjoeoU74ZYSuGHxDYSGRd9MIPo/RtdO0E0uOpCYv/0Q=;
        b=UIKCFgt4EwNRHy9YlZUf7xhlnq5U5rrmiljdpYNahl/fK5tHJhhvhXG0h2gq0Ws5C1
         2wJmNDtv11jQidwVKdGREFAkf57HPxgpiIWKpdmFsMXzUXeGwF/mB4yd0s3AN6cGvDw9
         v9Ur8Jk4VaJFCQiTGX4Au2Tw+25mkg5v+oLtv0Rp85YFCv5VnxvUiJM8heqjuoJ6OmEY
         B8LQPcPHgF6xJtLWncWRAYRmojdldBpF99LFdq9onwuuL9uTv8zLDaEAhKVxh1sD6rU6
         StvB72OkJL8K+eE2YTQr2RBRiHKN7onz37SDUIh+G1/Lv0JW8jIIxsXIwK0p6iassLLK
         n84A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791435831; x=1792040631;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GjoeoU74ZYSuGHxDYSGRd9MIPo/RtdO0E0uOpCYv/0Q=;
        b=jA88nGTNYUoZ/SN8pPl4AUes6ZDs1MiyMLGmy8wS0HY9c1i7jgLxNk4fH4EYBVVe5g
         lRgTMngdFgoDPt8zQorxiMQW5EYgwO/TSGOyKM3227tewYdgfxiDqj+coi4t6esxT4in
         JTgF2SfW45cH/1JQL+vrpBYiohQk5/vNydpWtpD3L3MuvRBGURiq018c7mV1WR2H+BOn
         TZ9XlsM60aBgdMiLa8rIuaun6JM6pN5dVgCtwTiFe0dK8X539WcVuqKxuB7UNhf122dO
         2svSDJY/IznKt9aSUQr31to2ikGJGAFENA/yWPOjdBtKOkU38Ek74GuOuZ2CSw/DdGdV
         C1Ag==
X-Forwarded-Encrypted: i=1; AKwUvByRPqGMFgQ/mDSlQOzEKNE0SnaCteqOLToB23H3fj23Otg1iQ8pJpNFeB75nen5CvZB453gRWEOVeO5/ZP1@vger.kernel.org
X-Gm-Message-State: AFuF++ltsLVsFyJWWX4fDXLUJcM3ddOsq+m5jYHttGd0yyDgzdgMY/U8
	WiPv5Xsz4lAHnDPCgbKghh4vpeEE1AfN0q3gzvXJNgXVL/qDZHtPbnknyBGqvF+E1alnF2slh1A
	ZYd+AQniVYwo/xT27UZaH/slO5bp1HGNExe/zolXy
X-Gm-Gg: AYBFou273eYwJiAw6iXKMqJfqaQdt3wBxB6Gwtb2tLhdNpD5jgXJw7CF/KO0QFhr/c8
	jpjx+L4TYDMfMPJqRBLoewwLT1C9Zd5FgrAewrdrSIKcZyfIxkg9GGWA+/SAUe6YcgAoFCIVEcO
	aXCnGWf26tKAPZfdqtsVrd9zphGB0KYzrmy9RtPhI3AzsvxBbG9vmfbJtQZho4uAj08zSoppeY/
	RgjoxKq+SCmHfBkGKj9w3HPmpRVMu5t2p38LeRQ6CtsvIr4kQPZkSoRJVPYkn+EkF01jotDfCxg
	j7SPgRDIEcP9jSHPz/+ZPYqKzjFD02yUsSVtX0nnyKsqn3HaZNEb+ZNKf/T1/9owDBvyULSH89R
	PZAtlt+hFguv0XOqOOQew1bq/EpnfZGrl3PbiLmWEyVmy67Z/+A+iiYvMHXzOhRIgbN/0PRes5h
	b4s1g3lUDAi+gzYptpYgdz9i7O
X-Received: by 2002:a05:701b:2602:b0:161:3942:c07f with SMTP id
 a92af1059eb24-1620a9a5ad6mr5199767c88.47.1791435829062; Wed, 07 Oct 2026
 22:03:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261005-work-unix-passpidfd-v4-0-350183b6e02a@amutable.com> <20261005-work-unix-passpidfd-v4-4-350183b6e02a@amutable.com>
In-Reply-To: <20261005-work-unix-passpidfd-v4-4-350183b6e02a@amutable.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 7 Oct 2026 22:03:37 -0700
X-Gm-Features: AclHuK8bNKhRRVOZdGlnqbecyJoiNU6TF2RIFHGHC-yiG-BKj77USuxK7OP9UOM
Message-ID: <CAAVpQUCK-AAQWMP3nM4maaHAVE1hvh8Dt0yLBhq9V_d9CVETEg@mail.gmail.com>
Subject: Re: [PATCH v4 04/10] selftests/net: SO_PASSPIDFD_THREAD
To: Andrew Halaney <andrew@amutable.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	Alexander Mikhalitsyn <alexander@mihalicyn.com>, 
	"Christian Brauner (Amutable)" <brauner@kernel.org>, Eric Dumazet <edumazet@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 5, 2026 at 8:09=E2=80=AFAM Andrew Halaney <andrew@amutable.com>=
 wrote:
>
> From: Christian Brauner <brauner@kernel.org>
>
> Extend the af_unix scm_pidfd selftest with SO_PASSPIDFD_THREAD tests.
>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> Co-developed-by: Andrew Halaney <andrew@amutable.com>
> Signed-off-by: Andrew Halaney <andrew@amutable.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
