Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800DC175A6E
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Apr 2026 19:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775071509; cv=pass; b=jP7C7Fi7InCI3eyNmHjqfCr9Xauaarukiv7NcdYQUafMnnMApxS6LA+HDGpFsAfM4n0lSrRmGivE4p8qy3iLrAeRj2u2QhEgr09frkvYaxnCCOsBJQyc3ZOFxxifEUzRPXGzwtXt44rL+OQ07h1n81AFefEdz8AA35iZ5VLxsWw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775071509; c=relaxed/simple;
	bh=E13s9ySbYGK+vB8GX2N0piibVYX27uVfmrQEHfUUl+c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=abY6rG19N59lD9Hp1+EL+YnGaPKi6t/VdRCBCeovVqwlWskdJaZ1CijJZcKyzfJSSDK6OukYBHrtuT7nRgt56OJhfQ5/jiNk9MqaCdrm9zMI2VQD1sUuy7owUoTIcFpxp0wdaR4n3dJMmWJ9AsJAel87tpnXmktCs8TPfPNf7SI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z00+8Lq5; arc=pass smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z00+8Lq5"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b79f8f7ea43so12621666b.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 01 Apr 2026 12:25:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775071507; cv=none;
        d=google.com; s=arc-20240605;
        b=TQIL3KQx9ErgQu7xffCOYq47fkIJN13grE4LEFXmZ73vGVG9O93wUJuZOt88ni9byu
         HOlWT8NYtF4acMItaJPDgwxYxyQccfF9qLq1Iz3axnmoZjlTMb0TXsV6BThlmcERxZQY
         HhPkGV2q/1s+S5aMeo28euAFAjuVQi9Az5Du0xZnirXMK1cRwFnlIl56qApm2ZKDTtGH
         eVVhKmo33YZvB5haoceD0FrL1tnyNI4o/hmFPA3QcuXh8+S8wUphHHapq5SBH8kF6YZA
         LoNbqCiLilKg/jPLi/7xr05ZiQtK2ptLgOldWxJwQ1UHl/1DIQ9Hrr6Umxm5/NO+QqEf
         CxqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=E13s9ySbYGK+vB8GX2N0piibVYX27uVfmrQEHfUUl+c=;
        fh=lzC+ELO0PVQw8U0UEPCf6er1wNPD29SAvMhu/1Gh998=;
        b=cz/n503uo0LCPFAHUO6xtrzD8uj9ZBxToOLm8WsNyeDrxO0+cvgPKr71daegXJKO/P
         YpM+9u0VIyka4GkMLmDc193aFPfboR0eqb5ZbLOeR//SICkrB0fbSAAjeDuh/rRZCM10
         H4PHA0liRxXf/UTppQ8OtB+uH+1OICwGjLI41pMXpzbtQqt0PiQ+D/VNkdBGkaa9ulDy
         zcjznuLaJ7yJtcva+7GgAdtgH7DoWVE6BlaVehcVaXiJFOAnzaTSIXMfkjlHPgUEzvB3
         1T/GHXX6FoGPQoZd0kqDq1QUd1J+5UXV9RHVTEZgE6ro6whBruj/GpYJAYTBnYAlPqwF
         AkxA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775071507; x=1775676307; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E13s9ySbYGK+vB8GX2N0piibVYX27uVfmrQEHfUUl+c=;
        b=Z00+8Lq5bOXTlXY7A1SO9+XPztrcv0FLu6lDapp4vVFdki8balrNzxZv3RKctqJXy6
         wwfDsMLVFejR1mJZ2S/RSRxeyT59uGXPF5ZVxnnnb+ugYVQckbW66JnxrYwtrIlW531c
         raJqNTDvJdSWkUqVjg4mJLPAaNdaU4IJa4A6l+f7Tacqd2iqEmVMoXd4wiW2S1xx5NZq
         khuvCnQbNPKhLBlxIssJ9Jc2jeCnLmz9MeNaM7j7q6CdEBUUo9CGIzX71Xj6FbV/Ju/W
         qjx2Y3IWaufJ2b1/1584I4Nf1chS52ckRYnUs2uE5Ev0DNR2WWPmQwbmav0zBUSckAfg
         o5UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775071507; x=1775676307;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=E13s9ySbYGK+vB8GX2N0piibVYX27uVfmrQEHfUUl+c=;
        b=JjtQ7F0IDUH0g1DAVWtJXke4/oaM0yTzzBHYLXmXtdd/TNju5uB1PK8uOXNl4wQBWx
         1/0Rsm7HASBoUIYdwX9ahjfITY4BcXq09d4LkuDrLTfZjjwW1WV006hxDGHCHju9YpNV
         0XrSsSOhZIOrU5JYtOf0sVAgnbKLaQDQRelJ5tNB9i1lUeLcKiCSPB0JDVBkm7pKvWwd
         QJa10k3ybDswHgjNM+af8wMafYKZ+v2JPmHgwt3Su1SylnHGODdy7xAhWcCQeuyb6fkb
         0NWAxQa8AnaaLN/DCiMrdNlozCm0TJVdNjzqOPyR1zG1CirWHFw4cLJ21cpwk9CYgUBy
         Bg/w==
X-Forwarded-Encrypted: i=1; AJvYcCUsr5NOLWs94MJykEFdys0iQyvCWylfJQALOqMBWLuHHfAlJP2YDD0ZFWvHGyKFFpabjtcKOWRxlRddFVwA@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+68Z/wS2tktjw8sST+G4owOSZ9VzNbWcvVYCpIdsL/bosHgqG
	WS+fVDh1SN1uDAYC1cxmhwZLcFR7G9RjMYNYvn3eYiqV/bs03OpwMVX8JvGSMBcH/+Wb+ie73GH
	86SILj0vVaJYJ7OsdPU9PWZepwMO7qog=
X-Gm-Gg: ATEYQzxUiSplw6tEN3MsjBl9r9i4KzTj0xQQ/iV0qb5YqYR7mQle16hddjyyaqqZS0z
	MTIGMsPAZ/dvU4j2bocODzPa9ZswnokzWXL8mD4fS2AYHLvz2+xNvg3LK5NSVBbXHRYg/Z/5LiK
	LzXjeleQn5SQUAU2ZD+bt5YjzeN98jhLf9Ceesmyd7CmYwfb7u3qvrPKnoSLxr8s4wc3M0VTZcZ
	9QaBSkp5Woobj9lQ2ijiQOvkGEJv61obB6Z3gaSBwbjMglwxLIfBpcTr8vr+Hq0zXzfqO8QeoZg
	DdWYvud/HSLJjtU2tqa8vnY+dXINMYxkf7xHYjs=
X-Received: by 2002:a17:906:f185:b0:b97:4e42:23ef with SMTP id
 a640c23a62f3a-b9c138f8b82mr197503066b.16.1775071506521; Wed, 01 Apr 2026
 12:25:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260401131226.4011156-1-mjguzik@gmail.com> <mxbttfswskgpmgakwz5cja4u3gzroonkqcqf4yggybtfolp5hd@qt7762avy5qf>
In-Reply-To: <mxbttfswskgpmgakwz5cja4u3gzroonkqcqf4yggybtfolp5hd@qt7762avy5qf>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Wed, 1 Apr 2026 21:24:54 +0200
X-Gm-Features: AQROBzDmvawUl-FnIaJ5z_jO7D_jhr8iGXhzOvIqVvQPx8Arl9uNEtrOD8qoF80
Message-ID: <CAGudoHEN+NMizX3yF8bDsm6+y0-jyFb5-fFogHWs3=F4MaHOPA@mail.gmail.com>
Subject: Re: [PATCH] execve: block Emacs binaries
To: Pedro Falcato <pfalcato@suse.de>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 1, 2026 at 8:37=E2=80=AFPM Pedro Falcato <pfalcato@suse.de> wro=
te:
> Can you block vim too? We only use ed(1) and GNU nano in this house.
>

I heard nano is a company-issued editor at Suse.

If I wanted to mess with Red Hat I would block mcedit.
