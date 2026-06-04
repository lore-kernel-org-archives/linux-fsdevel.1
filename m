Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0024F40F8D6
	for <linux-fsdevel@vger.kernel.org>; Thu,  4 Jun 2026 17:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780594413; cv=pass; b=maEc30/mz3swMB5rgENGtmj4kWzNzMpQoqY3ZW3wLGMPKht17zIXtWmNBAmOHNLUlHb9bDJO7GRmAez3bId7yj5WpCWmZ6dLFFMfiQS91EX3WSG4/zGJLOcIBq8oGQNob4dYgFGidFWsqanliB8nd3FO7pDVe6hqHpzqZ9lU9rs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780594413; c=relaxed/simple;
	bh=owJXnybiws30tAExuI+1dVSdBUDHcYFlEd//SjpvxI4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eRLR2NmiePH+J0Q+09jPPxGfDiRk7xpJrzGmV3Pm1C+IjQB4GsAcmqP6Ji5/nLMBge/yNbCx5Thq6hai+Jx5nnKu0MbSdRLQpQVPmkxy/Jp8lyjFQtGqlNkMJTpi3KJzqBh6y6KUdcmks2z6T4v13lXXyE6VWy2bwdoFUAgBssg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IPUDdCYV; arc=pass smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IPUDdCYV"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-45ef82204c6so577572f8f.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 04 Jun 2026 10:33:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780594410; cv=none;
        d=google.com; s=arc-20240605;
        b=LNGLTQDwxVLvvkE1/DyK5hVJstzAnenrjLl+/BkbXApk0zRbJpt3H28YQ0HLGGzRmL
         VCuGJoj50qbkZPnJ+Rg2REfL4tm87kamKeb/1epsflixPBHz8/MQl5d/85z+9MpFqTw1
         Hrc4gLxehDbWXQAOvqI8FsvG4Hl04athC7VOfbVudkcQVvA80BfUD46LwbMVoc1kCwZa
         TiuVzwXaXY6L/SFEqybt9Gf9CSie9YubRSoKKEBGr/feGdpCM0bwIl5xI/uM1nzVo5sJ
         CKmYY02xfEnkW+N0oipCwGqrL+vQ04nsvZtVYslxYFSxO5W/PH4QDSpzyQ1zaq9gzvFA
         fTmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YRQRq+2vK2cF7uofLapd5v2EYNDuBv9qQx7bQUApxHI=;
        fh=vyEQCTg6rlT2VH1j5hX9ZoB6MUbT6hs3pyRgYDvSq7s=;
        b=FyqMO4A7+GpkTKrl7lERKR9n6HIwpSVmzPNZRjDWmvYncjQWPj7pwYwn1L7/65CG61
         eKnu9wv/Xp+CGZiIU5GzeELSZsMUBF9it5NXK+wXzXJUqu8IK8Wrsr/1+A+FDuEP9Rl1
         2iWyeh3Cd1ymnAgllusj4NnNnExVUk24wRkkgbHK6TVBHrcrNohaRxR9NL+oxhTruR7N
         R+HQKDIYS8wdy3ighfFS4P2SBYik861JVupvLfij7IQUjhDOYfluXp/lQ871H9b5+9+O
         7WP7052cU+pdxOFosrnD0dq6Z1H/4hTk0r070ct50/e+ugc1lH19V76JI7o25+gSAcn5
         rX/A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780594410; x=1781199210; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YRQRq+2vK2cF7uofLapd5v2EYNDuBv9qQx7bQUApxHI=;
        b=IPUDdCYV+2UwQA3uceMoAq3IzhB6YcxFpUgFEduWYUL/7ldGllxGSqqcPp5PYLBIuA
         hSnwziCcYHrt4BhOzF8etY2pa0l3n6NewdWBBxYD1F06NUOP3n5wLVNMgjJeCLHnwfyc
         5WRMpONO7tODsGkzJhQvhYsPQDKP+ynE6g2YMXYI0eJPYsCtoYQZur0b4yy9Ylj3MqZ9
         iXrs6klNQfqlDqP9bSyknlEVyd3bO6BduQ9jivWwQDHHgSeBgqDXYnwPoj5C/oPGqY2M
         FQteG6yDlj3JfmKCl7jCnn0GY71+u8L97puyt6vLPYJKF2VKw7qpRtqmzlhaG8PERnsh
         +9KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780594410; x=1781199210;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YRQRq+2vK2cF7uofLapd5v2EYNDuBv9qQx7bQUApxHI=;
        b=RfgTxY3p7kg68UU1Whsn3LDXDYdc2+qYDt+4jQENjSHM2hAcNs8hDTorSCIEd0jLJs
         vLnuH58gZ5v9TTdhNmccOKPOqVaMKvju1ud8Mv/blYgX0c5aBMZ1HVBOK+7XW5wyuK3Q
         QdeQOZ3lmDTlIWMucBbLnAi8PCf+Kd6D5IGT6HzDJLBMaBvCIGbRmxZDQj0M1jwpPbtq
         JzPg7jamXo4PfA1OGaMY8+VMwISIgCCBmwCOAbobO5+D/hRg2EAp/pBbzCxsGwDM8bb6
         O1attoXOHa/jsi2UiDWfz8UD+HePXKS3bCLMyQGco4Pn7tgwK6XoWuQvpSDgT+VhtVNc
         iDlw==
X-Forwarded-Encrypted: i=1; AFNElJ/mKoyzZWk3FFqkqxcu63wmvVk6UgJbOkXDn0UAJUjX3MuNFZ1F4gD7zplZTUBdPwXWSJP5eUHRnZTiQfRP@vger.kernel.org
X-Gm-Message-State: AOJu0Yxj3QmNW8UMdhG82ae8H5wPlI3Imeg3znNgIDvOH8b7k0GR9P/O
	Y2nOR5aZPUhIxpHgu3n+WwUGSfP+gLhC0CnuA1LIHBlIYkeyJ/W2DFD09GYuXSpaN+f9X27XCJl
	hyiUM8xh2TCYWSPWMecXL8haUYd8fIb8=
X-Gm-Gg: Acq92OHuCcy6Na8vJnGWP8XB2If5y1LgG59b67XzlR2+IHIyX9Uqmx8LUwXhoGEBOEy
	lnNOGRzJKUTY/3LvRFEfT5nRhPplHa+2uBV2ncwE+AAqUIzWGy9rY1uI9yAlNxlqN4VZOhwwy9z
	Xx7EFUIcQQpPfgI34yjIRqQsOFAOMBiWAZ1/wT+Y6NKmzFPaQht9n+vXAX/FRXj1ylR6BDtfQAV
	/7A/uj+mKMVRZxDKYjZfJlb8eP0MYXngFNDtYGa5u+Gm9cYtqptU3NOjlK+uU87EhkROfQMFXOB
	3JIwVGWV0caVG0d82jcFshAX0s4=
X-Received: by 2002:adf:f282:0:b0:45e:da57:be33 with SMTP id
 ffacd0b85a97d-46030502271mr107732f8f.23.1780594410151; Thu, 04 Jun 2026
 10:33:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <178059213410.15421.10567268398539539875@gmail.com>
In-Reply-To: <178059213410.15421.10567268398539539875@gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Thu, 4 Jun 2026 10:33:17 -0700
X-Gm-Features: AVVi8Cdg067zhUefXO0s2A4H2Goc_l5Z6srpulw_ymDh1bJhi1yDH3xED4qHMCE
Message-ID: <CAJnrk1YH_SC9doHp60Vuajc-mzQiopPExMPQVVDtFHzB8vTM6Q@mail.gmail.com>
Subject: Re: [PATCH] fuse: {io-uring} use request cleanup helper on commit
 setup failure
To: Shuvam Pandey <shuvampandey1@gmail.com>
Cc: miklos@szeredi.hu, bschubert@ddn.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, fuse-devel <fuse-devel@lists.linux.dev>, 
	Zhenghang Xiao <kipreyyy@gmail.com>, Berkant Koc <me@berkoc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 4, 2026 at 10:09=E2=80=AFAM Shuvam Pandey <shuvampandey1@gmail.=
com> wrote:
>
> fuse_uring_commit_fetch() removes the request from the processing
> list and clears req->ring_entry before moving the ring entry to the
> commit state. If fuse_ring_ent_set_commit() fails, the request is
> currently ended directly with fuse_request_end().
>
> That bypasses fuse_uring_req_end(), leaving ent->fuse_req pointing at
> the ended request. A later ring entry teardown can observe the stale
> pointer and try to end the same request again.
>
> Use fuse_uring_req_end() for this error path as well. The helper clears
> ent->fuse_req under the queue lock before ending the request, matching
> the other io_uring request cleanup paths.
>
> Fixes: c090c8abae4b ("fuse: Add io-uring sqe commit and fetch support")
> Cc: stable@vger.kernel.org # v6.14
> Signed-off-by: Shuvam Pandey <shuvampandey1@gmail.com>
> ---
>  fs/fuse/dev_uring.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
> index 7b9822e88..7523569ff 100644
> --- a/fs/fuse/dev_uring.c
> +++ b/fs/fuse/dev_uring.c
> @@ -924,9 +924,7 @@ static int fuse_uring_commit_fetch(struct io_uring_cm=
d *cmd, int issue_flags,
>                 pr_info_ratelimited("qid=3D%d commit_id %llu state %d",
>                                     queue->qid, commit_id, ent->state);
>                 spin_unlock(&queue->lock);
> -               req->out.h.error =3D err;
> -               clear_bit(FR_SENT, &req->flags);
> -               fuse_request_end(req);
> +               fuse_uring_req_end(ent, req, err);
>                 return err;
>         }
>

Hi Shuvam,

There was a similar fix for this submitted a few weeks ago by
Zhenghang that was sent offlist to security@kernel.org (which I think
was before the announcement came out to cc the public mailing lists
when sending fixes to security@). Berkant submitted this fix offlist a
few days after that as well. Sorry for the duplicate work.

Thanks,
Joanne

>
>
