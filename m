Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8429D35B632
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jul 2026 20:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785441734; cv=pass; b=E7sgah2Lq127pr25q0ah5oXZMqvRDw7rVI9BJpYirDJrQt8OPA0dpbg7ilEZXFRS+MJTiS5d0M3rNCERy9G7/h15meqqoiCDZ4kLeYPRndGZMy4uXOj9rBHLKEBIl6CM4SONbhIWqmLzxE0HRCusMJVEOVGFT6FTP6fhqV+CEa8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785441734; c=relaxed/simple;
	bh=qZzJvUfZRso2RO/UiJzxOrayFiOAibqbjT0CxiatzVU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OyLvU9mN+Aktw0C7YUD1DHwlxR+ZW2t9kC9/nheovY/C/oaSmwjD7QRh0oOTdOoOGsdDkfknqBIbMEFYZw+SbiR/vxixeJqo0wNtlLLsQvlzcam/u6CgG9LwLONMv7KU7SM71FOGQ2ntAFnrAKaH/n8YzrtC5yxIhAkb+sa3s3Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q7TSNMSp; arc=pass smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q7TSNMSp"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c167aa9500dso19977866b.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jul 2026 13:02:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785441730; cv=none;
        d=google.com; s=arc-20260327;
        b=WQCwrrSKc4Y6VOCQa7oSRydfllbfg6mPLcnfSAyfk6kw2eZLxK0ObbQDfOevsohJoH
         gfDIpIN7zFUFFILiS7abW8ZjmUlg1jsdHSK0R84iqJWTkeSWtzWUw8CHh9WDAzUj6Zs7
         ffF3XKJpejpegcP4j+NXk5QsHSj2Q4mxBqgQ+bWo4hEMbaeF1InSbc6RIlnXZZTwbXEY
         79/NKsja5ZfvYw+CYSgLWqncFaYec1mmPAxM/GrMuUytsXSzErXUZZdpm48nTLsqyyHN
         wG/7+UWfCuqQ8kT4fGae2VkRugdwsSohqs/I4uydTnyrMnYLsxs+chFzW4fxKaP2IQ03
         NvnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qZzJvUfZRso2RO/UiJzxOrayFiOAibqbjT0CxiatzVU=;
        fh=rYw6Cpge+8+B7u1hf+QoCCmnoM2oYhWdeOb/3Q7Y0pw=;
        b=NNjGLlQe2DQqwE/Q5PJydMASB2sZHZx4zZgWanFdPtlPxq4gLqcEzTIjZJ9YMclGeV
         xLBoJFa/cA3uP+m7amwOW07qIRiY/ejkw3X8f5Hoysn4f4jCD2MvIUjzb8Vd/7vusVo9
         YwTHiw+GGlyrpYqgj63EJle3ckxM1iTP8JhL3ErX5MWcQ8LvNNMI6GcPeplVVQ6UACPX
         KWcA7g/5nodXI4eD2TvrNT6tff4i50AU38yzKYeTV8gmtG9pwjv8xZlxxL/FcOn989A9
         o+2fH7t2TIKJGL765sOeOV/7pwpWOS8c6DrEvpmWxm/Hx74z58qA4gfgvk3E+r4yufgQ
         JDDw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785441730; x=1786046530; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qZzJvUfZRso2RO/UiJzxOrayFiOAibqbjT0CxiatzVU=;
        b=q7TSNMSpXT4YEcFIPnfZKwpk7cEGsUr0fZdC6VOD+7xe1tX1gG1xz6Fpl83OIEoM0e
         0vYdSCa591l4hwNc852NAgxP8xUWeKgsURfUCPkK06cqQNT9u+NRYBdmYhKYmn62ZZ3x
         C3p5Zs7iIRRi+7f2z1CxE8y8LaojmfkPFNjg7JEvyzNZq7RXEadzGziMUT6w40feaM4W
         RDffI97aPoSDXD+ynKi2eJPFEhelGvk/bINlW28+g+jNgb+A+lHRP0yG9AUdzTo1O2EI
         BkhpyW2FL4ryomoowCfHvAUPj/QPZ6mOp5GN8E4k6FiAPQ1PpQZAllq1ovTnKGr+PiHV
         rQUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785441730; x=1786046530;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qZzJvUfZRso2RO/UiJzxOrayFiOAibqbjT0CxiatzVU=;
        b=e9w57QN+HBDre1LjfGBUgHnsIoP30FZWX4jydgwleT6VKiI9FU/7r+TSkcwUVrcKwH
         U0ZxLakVZANtLfvCCq5ndRWUCDjus3jrWyjt/1yg+U5qM8tZcKUncPvAKIY8YUH8VVgS
         nYElDWSeVLmqfrhggCOz8t7WPmbkEsvL0IF2TdBwuuT0FlFSbh9DuoW/9ISiHfm5fvPz
         tQxkaDxOOjqucLOSwBrmlVd5Psu2XVXQoAu2Q5KH+XyAvTg1wS1yfuEGuBgDCfv6rh36
         AjKwHsXokuCTtEJjHZGpJNuTqpsqO9ioQdWVt2YglbnmuVRjasSx2v/MEoK8YEIB5Eqm
         8n+w==
X-Forwarded-Encrypted: i=1; AHgh+Rqsw1rYuRYqmtlz5iPljipmvvfnH6DsWwr3PXAPKV+Xv/t1uKUjAooDnA2QlSO2Yi03rBudke7k/lQ5ZLLP@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8sxuo3LIh/gwloMt663uQlQIOA/aosi3Uer94TVPrrZe2Q74j
	0TTz88OxqTzdIL/xVSdPsgzx1qy6je7CXC+ceQQ4nK8deQaLLRKTZUSWhiPu4SWKGNeqC7VWLEh
	H9WoIDgJ6t0j4/fahvZQOji3YQFZaqfE=
X-Gm-Gg: AR+sD119xvM+UiMkE1YJrRXnGw1O9zjpdi/iesHGZq9NrKDqewNVn/lEAoeWWyo58m/
	6HCdISWbW4Bm4SvnmnsDRP5uay13rneS/pKpju05LzEZasyX9rzucY9C5wZaMIE5705VxGUAQxO
	7Q0t2K+3M7xV+aBDh3BjEuvZvjOrcaZ9Ic6iHzdhMxW/i1wHYqlQ5NiArynqVcR925Ioyf/Xg4p
	Q8XJeRwXE8a9TdWO+TVMOw97GRkiX7Psp54kYo7Ipc9lorhhVQsY1fpNvPwGextwXMGzBGBQNRW
	iZbTReZG1VZKIGJVAKxI+0IM+nUP1NBuWVaskLuIP7mbTQUgJBLlsDbdz48on3khrEkxhm3X+IL
	2
X-Received: by 2002:a17:906:d7c5:b0:c1f:6f31:2880 with SMTP id
 a640c23a62f3a-c1fbcbbaf9amr92661266b.50.1785441729813; Thu, 30 Jul 2026
 13:02:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <amtbpwrhlNGJ9OK6@redhat.com> <amtbxpqJ3pZwyT8D@redhat.com>
 <amteY30qxRuPzFh3@gmail.com> <amth6owVUdVOmyAL@redhat.com>
In-Reply-To: <amth6owVUdVOmyAL@redhat.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Thu, 30 Jul 2026 22:01:56 +0200
X-Gm-Features: AUfX_mxENwOXQ-caUgXqUerTbXH5sRM6Sld9GitjXaMQVP0pKFVSqUA-g6155GY
Message-ID: <CAGudoHE=GjMRKGbip8nRUm34VUud_YSqGZJrfr+Vz6Qu22Mdaw@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] pipe: only enable the extra wake_up(rd_wait) for
 edge-triggered consumers
To: Oleg Nesterov <oleg@redhat.com>
Cc: Breno Leitao <leitao@debian.org>, Christian Brauner <brauner@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Pavel Begunkov <asml.silence@gmail.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, Alexey Gladkov <legion@kernel.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 30, 2026 at 4:38=E2=80=AFPM Oleg Nesterov <oleg@redhat.com> wro=
te:
> What exactly do you think the comment should say? I agree with anything i=
n
> advance. I thought that "edge-triggered" provides enough info, but I woul=
d
> be happy to improve the docs.
>

how about: There is userspace depending on the extra wake up, see
commit 3a34b13a88caeb28 ("pipe: make pipe writes always wake up
readers") for details.

or whatever else which refers to the commit, no need for anything
fancy. the current commentary is definitely lame.

> And the helper's name? pipe_enable_poll_et() ?
>

perhaps pipe_enable_epoll_semantics()?
