Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60DB0501F46
	for <linux-fsdevel@vger.kernel.org>; Fri,  4 Sep 2026 16:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788540885; cv=none; b=ilgNRo5+t8XK1DtetQnW0NBJ/3DIraUFHt6jmUWQLo1H0ylyV2XCU7E0TxUR+gilVggHBY7hgjz8kL6j2P6aGox1+WASOGEyz4x9cmEz92aJPDo9DFS+ozQjCRu9E2BKuZQwxY/gfyJFcEdKwsP9Mm4tof8s1jjK3qS4yU1XbO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788540885; c=relaxed/simple;
	bh=ZdzwbYcSxFp1YM2NzyKteD8bxTtEzteMVXqKaxQGfHw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=loPw7DEPkFlQGyoyJmRF9Yo0gLeNh45hfC8XACSK/rKYdhPyNZtgUj+bDPET8gzYAKTx7AD48nS2f1bdMu4qPLY6FO/eJomxfAZ1TzdEjFHKaAoHq2iGo7I8chnX4GatReY/nYmVWf/wmsVGFIlP2nyf/ruJMMf9uPLABeKdYhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=black-desk.cn; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=black-desk.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5b60bc6b4eeso869959e87.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 04 Sep 2026 09:54:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788540881; x=1789145681;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GyJwn4+ssjywZb/F3JjOY0S6/aIo0tP90S69DFDLuSQ=;
        b=tE2oaURhMHGmB5KVRRQ9OGLZatug/aW0W/938lcd8dSKsHeJM8Cb+79DDNAybsiCqM
         ZwIOl9mO/MnYrzhVh5/SeNznnyy6A4hi4PiXpUdfe4SzymHY+b61BmaI+E6erC+d8giF
         Dy6ivYhJVHqkscLrXMhTY2veH40tZDnrjc6+HpDGgIiHWKl0Uory6UYdq0sMW/ispL2t
         UM5y8Bmz+uNhrU84IQv8GNS67v8q6dIcY+s2/dUnlTBY6ZZF79nK+QdrtxkPEpjCCvWb
         Gozcpe2vSWKrEutb7XFVElBmHOma1DK5/Uf7biZ6x0qbkMwR1wb37hOvlpjK44aNLKWG
         zQFg==
X-Forwarded-Encrypted: i=1; AKwUvByexrhAMmcs6VRZdaFK70OxRYjIIz54/7Vh8mxxox2PWkMR459CS64SRVBs0+A+O/Om6gbYO8tIE0stMUWM@vger.kernel.org
X-Gm-Message-State: AFuF++kG/SCZZBKeqzdrscAh83hZEw54kGuRT00A8XVLp/3n5iaoNXsy
	09T/dxM+uAKcGMFGFzmFEO2fKU9rzRgDtmWOwLalm9FRLlx9ayjfJri2KUR3xq5xCActCA==
X-Gm-Gg: AYBFou1THqc33oScBiGgJrg3oE4vV9F5Y4EBJJeamd6vIKsQ2ZH8Xs2xPGwGH48Mr+E
	OvtnoD8JoIr+ZuKVd6Ze1JSJd9NKWTzywQ8fSUgHvW8BLuKb0+TSJLT8Cg1b3LWHNna2eKsmozz
	9lIWSlXm2EJGDiu5qop0FmEpoFGV9xsAdCJ4aY5+Upqw2fJ5VzFX9dU1+hwThQw7UPz2nmqGIc5
	PNnyRHNojFe4wJDRNaWRYsjFW/OzA3ctdyPA6STrcNw+o2PJKbnQD2b3jAu+lRBPrERnow9jxJh
	IJ2djdv790KuLYptm3Deqhm9Uh1Vki8a8XgYvYgzfqRiJiGIzEfE5+QiToC3a1SFLZImqoKoLKJ
	smGNqQDfI887lPWRP/fe3F9elinrwX4rPQsETBVbtu1G7Z9zkA4UFHHVFsi0eYqP1hGl9wKXMqD
	7WMaUkpd6bkXHtcdWEfBJiAvjtENxIllT/TISKELIV4jIA2Go/Qu1RwPwkQLV9IH+uWHh+tHjz7
	ESfPu9o63TJIJjneXdxUDXqTKvHTTlTdwtNUm4eKAKhAlwtNTzIB5ctZ1A8LcLg
X-Received: by 2002:a05:6512:3baa:b0:5b5:e092:c3ee with SMTP id 2adb3069b0e04-5b616ed47f6mr2076837e87.1.1788540880687;
        Fri, 04 Sep 2026 09:54:40 -0700 (PDT)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b6166ecfbcsm652628e87.13.2026.09.04.09.54.38
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Sep 2026 09:54:38 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5b15dcaca31so1217857e87.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 04 Sep 2026 09:54:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvByXXve5ZMkp42WtS6rOyaFm1tfRCfRJq6zZqIfwQNQ9WO/EC1hfBpUFDbznWOW2j9zmtX+CQ98sO9NY14kr@vger.kernel.org
X-Received: by 2002:a05:6512:3502:b0:5b0:23b4:be97 with SMTP id
 2adb3069b0e04-5b616ed4b1dmr2357411e87.6.1788540878064; Fri, 04 Sep 2026
 09:54:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260831-pidfd-get-paths-v2-0-c59ea6a21b72@black-desk.cn> <lhuecf9cbl8.fsf@oldenburg.str.redhat.com>
In-Reply-To: <lhuecf9cbl8.fsf@oldenburg.str.redhat.com>
From: Chen Linxuan <me@black-desk.cn>
Date: Sat, 5 Sep 2026 00:54:26 +0800
X-Gmail-Original-Message-ID: <CAC1kPDPu41RxMLHpPtz4VqfkEZeu-fYXG76XVZMh8bbQa3okaw@mail.gmail.com>
X-Gm-Features: AcwNN1UgBltmpHY5GDpzTdve1vmhfclnbN_NvQgKzWwvr0zbygpAGe7Eg-teU9E
Message-ID: <CAC1kPDPu41RxMLHpPtz4VqfkEZeu-fYXG76XVZMh8bbQa3okaw@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] pidfd: add task path ioctls
To: Florian Weimer <fweimer@redhat.com>
Cc: Chen Linxuan via B4 Relay <devnull+me.black-desk.cn@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Kees Cook <kees@kernel.org>, John Johansen <john.johansen@canonical.com>, 
	Georgia Garcia <georgia.garcia@canonical.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, me@black-desk.cn, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, apparmor@lists.ubuntu.com, 
	linux-security-module@vger.kernel.org, linux-api@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 4, 2026 at 10:53=E2=80=AFPM Florian Weimer <fweimer@redhat.com>=
 wrote:
>
> * Chen Linxuan via:
>
> > This series adds PIDFD_GET_EXE, PIDFD_GET_CWD, and PIDFD_GET_ROOT. Each
> > ioctl takes no argument and returns a close-on-exec O_PATH file
> > descriptor referencing the corresponding task path.  The new ioctls use
> > the same ptrace permission check and nonzero-argument rejection as the
> > existing pidfd namespace ioctls.
>
> How would one upgrade the O_PATH descriptor to a full descriptor without
> a mounted /proc?

For PIDFD_GET_CWD and PIDFD_GET_ROOT, the returned O_PATH descriptor is
typically used directly as a base directory for openat(2) or passed to
fchdir(2), so upgrading it to a full descriptor is usually unnecessary.

For cases where upgrading an O_PATH descriptor to a full descriptor is
required without /proc mounted (such as inspecting the executable binary
from PIDFD_GET_EXE), users can use the newly added O_EMPTYPATH flag with
openat2(2) (introduced in Linux 7.2) to reopen the O_PATH descriptor.

>
> Thanks,
> Florian
>
>
