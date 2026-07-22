Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 282FE366054;
	Wed, 22 Jul 2026 14:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784731430; cv=none; b=lupz4Vuv7s7LkN4vl+9jCHGBNySRp2rGvB/M6dthDlwoL1azdW3jhgqBpZJLT2DhiNZOb5GI8OXa9fUPhwC8fYzpnXk1kPpGGuywB37+t/HfKhiHy09bXbCnU/kjrz0zpJqMsa143jqdDl/UhwK79HktbYTBzoWg0jxNkPwEMPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784731430; c=relaxed/simple;
	bh=ibqTAIsScEiNszBAsDr125DL2M6CEkBUuZ23CIZcFMU=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=ZfLHRHTHL65mh0hp+gRu3m+6syF9nNr3dk80elxZJrrLe6l/Sqt6S+H4N1dnvMZhXyxfWDzk7D1hiYOMTVnLmFITK7LgxZFqLmUR1OL33w1BDV98xpQpdoNajnLcnPdFMh9qjU4DIltv3y7LKRYY0uAs9LCG0ZRIRNU03jnZ9LM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YQ4IO50B; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YQ4IO50B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 473841F000E9;
	Wed, 22 Jul 2026 14:43:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784731428;
	bh=59/8jC27JVadinfLqLad43eujbp7I6xEA92GgSBWqC4=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=YQ4IO50B7xi/9/86Fj0iQh6TTDCETjDa+72MZDXHgthxzkEMAOwvheb0cCHXiwh3A
	 qlhJXOYoGlu649HFdqHw6XJLABrsGzXIceBIKlpDrB5d6jNlQOrtGA8isVugVvzdUY
	 1qL2f1TCHUDgL8R765KEvNJDpkWrWJ6M/h+p710qBPw1dXSFVY4qGr/j9oOUs8j+e6
	 MNWepXBC2LvPEiABBAGroM6ZQwyUYuez8HHOuF94XhyLXeSwkrsRzTmfAGTVIRlmVP
	 dIks/4iaTe0+TaPGS2gMB1FqgDNCYIoXdZPtJKmO4vkebPEJszI/grvGmI7IUsejmq
	 1Zxxt/gexaSGg==
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] audit: add FSCONFIG auxiliary record to log filesystem
 configuration
From: Christian Brauner <brauner@kernel.org>
To: Ricardo Robaina <rrobaina@redhat.com>
Cc: audit@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, paul@paul-moore.com, eparis@redhat.com, 
 viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, 
 sgrubb@redhat.com
In-Reply-To: <20260713170013.4073499-1-rrobaina@redhat.com>
References: <20260713170013.4073499-1-rrobaina@redhat.com>
Date: Wed, 22 Jul 2026 16:43:43 +0200
Message-Id: <20260722-ferien-gekannt-katzen-b7dd4dd0726f@brauner>
X-Mailer: b4 0.16-dev-2f6f2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1172; i=brauner@kernel.org;
 h=from:subject:message-id; bh=ibqTAIsScEiNszBAsDr125DL2M6CEkBUuZ23CIZcFMU=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQlXFd0Fhe1Yzkr4Pb09sZH1jcef226Ifa/gy8k3Z7n3
 sGLwky3OkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACby8zIjw4+MWKnQ6Lxr2izr
 65vD77hyyvf6tL2Y/TIysdVPjoMhi5Hh8NoriW9+Pd3z7/VLibNSv7r5zaz3nL4SV73aqfnww7Q
 wLgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

On 2026-07-13 14:00 -0300, Ricardo Robaina wrote:
> Modern mount tools (util-linux >= 2.39.1) use the new mount API
> (fsopen, fsconfig, fsmount, move_mount) instead of the legacy mount(2)
> syscall. The generic SYSCALL audit record logs the fsconfig syscall but
> does not capture the configuration parameters, creating an audit gap for
> critical mount information such as the device being mounted.
> 
> Add an FSCONFIG auxiliary record that logs the command type, parameter
> name (key), parameter value, and aux parameter passed to fsconfig(2).
> 
>  ----
>  type=SYSCALL : syscall=fsconfig a1=FSCONFIG_SET_STRING ...
>  type=FSCONFIG : fs_cmd=1 fs_key=source fs_val="tmpfs" fs_aux=0
>  ----
>  type=SYSCALL : syscall=fsconfig a1=FSCONFIG_CMD_CREATE ...
>  type=FSCONFIG : fs_cmd=6 fs_key=(null) fs_val=(null) fs_aux=0
>  ----
>  type=SYSCALL : syscall=fsconfig a0=0x4 a1=FSCONFIG_SET_BINARY ...
>  type=FSCONFIG : fs_cmd=2 fs_key=hidepid fs_val="<binary>" fs_aux=4
> 
> Link: https://github.com/linux-audit/audit-kernel/issues/153
> Signed-off-by: Ricardo Robaina <rrobaina@redhat.com>
> ---

Acked-by: Christian Brauner <brauner@kernel.org>

