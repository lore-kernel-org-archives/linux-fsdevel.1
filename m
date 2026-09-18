Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A5EC2931CE;
	Fri, 18 Sep 2026 10:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789727208; cv=none; b=KZUKz4PBSJDg3SuVTlVVXRI8mkHl+pkIE9S2bwTQ9JmFsLakxSUAlpTq64A/FSDua6OAQ/KnF8SrFLSJJY98uly/TdQ4qzW6RbQKZBRBqvq4HZ9jTYzF58u2uxiXxC3ZKi+AsPQFOxojZglC4vKXoBcc77CPdbFjUKXXa/jQH9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789727208; c=relaxed/simple;
	bh=YYRcMyhB+Nej5aB6tF0sD+lIuvpvABvcw+09Rps8EHM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=aIqQtnAqzg7uNCO9JPr1pV0KYYQOi2RqMof+xe2Z5RxKw+Hh7yCvI2IePbgrSG0zl58olFk9ilI23E1VmgXa8ZJAuBnDNrX/xyZtCQLKBXX9ItYdLGcW8ha71f1/xhmqbKO+TjMBwcwtUiYc7gajix/qBDI8IgGrxl01tgmi7O8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=fail (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eupBYsTA reason="signature verification failed"; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eupBYsTA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5197B1F000FF;
	Fri, 18 Sep 2026 10:26:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789727207;
	bh=5+RK1cJzE7vYEJNH4KMTogSsel/5JlapcOCdBl4VlP4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eupBYsTA6h+6JQa2ShdpohTKsfpx+UdpDggKnPH+KXXFxsygHGJ3gVN7254T/GPMe
	 CCJuO2D+n0H9tMNb5k6YwM/32ifMNPqfHtQSFOCBaZj6dRWQ1vzKk3XpZyXdNfGkx7
	 B0Js2Z4P3IKPLnB+2SOz682eQuD+4qtrx8oYjMSHCPVu5RKdrncN8SQoPWtTZHGmte
	 Q4tbyvx8n9a4FX/eeC0AihF8aWsPxSvZDHDagwVODDYyAxhyaTW+yVRyV2j2QDDIoa
	 SpZ4/7ywTZa0GyrUoyi/T60ERtnAj0Y2RgtK2FOpO+4su/jwnsmyzw4AjMeXvnu3vY
	 TSIYXJPdwk56A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 13/17] crash: Assert device_hotplug_lock in
 crash_get_memory_ranges_nolock()
Reply-To: sashiko-reviews@lists.linux.dev
To: akpm@linux-foundation.org, me@linux.beauty, takahiro.akashi@linaro.org, linuxppc-dev@lists.ozlabs.org, driver-core@lists.linux.dev, maddy@linux.ibm.com, hpa@zytor.com, yeoreum.yun@arm.com, lizhengyu3@huawei.com, loongarch@lists.linux.dev, mark.rutland@arm.com, blum@kernel.org, gregkh@linuxfoundation.org, rafael@kernel.org, kas@kernel.org, pasha.tatashin@soleen.com, linux-kernel@vger.kernel.org, chenhuacai@kernel.org, palmer@rivosinc.com, robh@kernel.org, ardb@kernel.org, linux-arm-kernel@lists.infradead.org, seanjc@google.com, tglx@kernel.org, thuth@redhat.com, tangyouling@kylinos.cn, adityag@linux.ibm.com, x86@kernel.org, pratyush@kernel.org, kernel@xen0n.name, liukexin@kylinos.cn, bgwin@google.com, ritesh.list@gmail.com, will@kernel.org, dakr@kernel.org, chao.gao@intel.com, sshegde@linux.ibm.com, ruirui.yang@linux.dev, zhangtianyang@loongson.cn, hbathini@linux.ibm.com, jbouron@amazon.com, sourabhjain@linux.ibm.com, kees@kernel.org, gshan@redhat.com, mclapinski@google.com, rppt@
 kernel.org, guodongtai@kylinos.cn, coxu@redhat.com, piliu@redhat.com, ruanjinjie@huawei.com, maqianga@uniontech.com, mingo@redhat.com, linux-mm@kvack.org, mpe@ellerman.id.au, chleroy@kernel.org, graf@amazon.com, linux-fsdevel@vger.kernel.org, bp@alien8.de, eric.devolder@oracle.com, vishal.l.verma@intel.com, james.morse@arm.com, catalin.marinas@arm.com, npiggin@gmail.com, baoquan.he@linux.dev, "Jinjie
 Ruan" <ruanjinjie@huawei.com>, dave.hansen@linux.intel.com, leitao@debian.org
Cc: kexec@lists.infradead.org
In-Reply-To: <20260918100442.3841135-14-ruanjinjie@huawei.com>
References: <20260918100442.3841135-1-ruanjinjie@huawei.com>
 <20260918100442.3841135-14-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 10:26:43 +0000
Message-Id: <20260918102644.5197B1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

> crash_get_memory_ranges_nolock() walks memblock, which memory hotplug
> modifies under device_hotplug_lock.  A caller that does not hold the lock
> can race with memblock_double_array() and iterate a freed regions array.
>=20
> Add device_hotplug_lock_assert_held() and call it at the top of the
> function so that such callers are caught by lockdep.
>=20
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918100442.3841=
135-1-ruanjinjie@huawei.com?part=3D13

