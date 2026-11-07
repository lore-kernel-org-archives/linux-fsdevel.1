Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794073439;
	b=LWZhnYF+oDbnjyyaCfVgfYkUVs1ngCGZVI6+bbKg5NMSTXfZMZ/uRlWlUV3KbehkuLGg
	 kzOAHLNaunwSiqXrePz6a6NPOegpCrnX73nF8Wh/YyLzlFngNEjYW1vbHoeQY//pBlzMa
	 2EpOmEKkd/qV8zGs39uldcJaXKJ0n5psDtnc5XTDt1IQhi/BiFuJfd6pbziOpalKWQwWj
	 BOPzPujFjcUCE2EftcsFMevYU7qA7bLZGrkgbylT5yyuIJA/QohgQ4P8VHQW4aVp/nVJ/
	 KcD9ptqDxLgebX3TiJ770THh8WJbmFzN1nfWVf8CNmcZt3EvCVAwq3dTnCbMRrFJHBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794073439;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=GGq589h5eOWxVn8W6IXN4b0IB3BiHtLk7CoyJEnDMNw=;
	b=mz/vzfPNjUt2UP6VeRKGX9YscqtPN4iFJ8FPoYljfRRHlQFvRIZxcW98+j2crWaRC406
	 lxy2x1idpvbXUgaVFlWa982tA8WH4umoCNvw6R9XTSBYtnO9huUVaST5b9UksoROqApTS
	 ZYpbCl2MzeL0znGg+pykh72FUXkzCMYaVRq1QlYNT8BfEMpMEX1EHuG+xKbErvaJEEG6V
	 e3KrcPks0j1qrNif320/+m3S6Za8x2qLZOgrEANH3RgsLN3IWdHSgwPhuMnqI+QzIgNyQ
	 TTRmvMCAK7tZIsKjRqwJpIQZgtOKLuQ7+JCrZJmfVzOKRwgm0jWPwSwpSwJ1/K3ZauA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Te6EbcG9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73AEE606A32C;
	Sat,  7 Nov 2026 17:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Te6EbcG9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31B6D1F0089F;
	Sat,  7 Nov 2026 17:43:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794073438;
	bh=GGq589h5eOWxVn8W6IXN4b0IB3BiHtLk7CoyJEnDMNw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Te6EbcG9aPvs2NCvT/iPXFPXErNvLFf06jv1CSrd/neusK87ra9w1+K+hNyBmpEUB
	 rTfhSzEFBXdWnS8ItD7s3eK19lVj1TrX7ViuwfZUT/ASgs8RR6v1ccsT8zFpR0tcEW
	 E9L5V7ZnVRTpRl+vhd91DXB8fCgI+RomU5ny/G6LgzJsLt3vylS5L4rPMQwAKji50h
	 GSu+ig3+j2nBYxfwGVf+NTJ3Fd0p+Gk93R2qgmKKJt6GLiH29w+uehl09cD6V4Vpam
	 CtGqC39SND8X8RPVpODf8AIoK82Op5PohRjbALXCeqjUfcrm2aqyxab5wnnnxNKZQZ
	 rYOtwJzkVMO2Q==
Date: Sat, 7 Nov 2026 18:43:52 +0100
From: Joel Granados <joel.granados@kernel.org>
To: wen.yang@linux.dev
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 01/39] sysctl: replace overloaded extra pointers with
 typed bounds and context
Message-ID: <au9L9-UqlO90UbSQ@hobbes>
References: <cover.1793204511.git.wen.yang@linux.dev>
 <fec089bb7a3ea62a5e2006cf578b1efec2df4aff.1793204511.git.wen.yang@linux.dev>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dylffndjuewr4vwx"
Content-Disposition: inline
In-Reply-To: <fec089bb7a3ea62a5e2006cf578b1efec2df4aff.1793204511.git.wen.yang@linux.dev>


--dylffndjuewr4vwx
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [RFC PATCH 01/39] sysctl: replace overloaded extra pointers with
 typed bounds and context
MIME-Version: 1.0

On Thu, Oct 29, 2026 at 12:34:40AM +0800, wen.yang@linux.dev wrote:
> From: Wen Yang <wen.yang@linux.dev>
>=20
> struct ctl_table has two untyped misc pointers, extra1 and extra2, whose
> meaning depends on the handler that reads them. In-tree use has grown to
> cover at least seven unrelated jobs: a fixed bound, a bound read through a
> pointer on every call, an object or namespace pointer, a small integer
> cookie encoded into the pointer, a lock signal, NULL standing for "no
<... snip ...>
>  #include <linux/nsproxy.h>
>  #include <linux/sysctl.h>
> @@ -80,6 +81,8 @@ static const struct ctl_table ipc_sysctls[] =3D {
>  		.maxlen		=3D sizeof(init_ipc_ns.shm_ctlmax),
>  		.mode		=3D 0644,
>  		.proc_handler	=3D proc_doulongvec_minmax,
> +		.min		=3D 0,
> +		.max		=3D ULONG_MAX,
>  	},
>  	{
>  		.procname	=3D "shmall",
> @@ -87,6 +90,8 @@ static const struct ctl_table ipc_sysctls[] =3D {
>  		.maxlen		=3D sizeof(init_ipc_ns.shm_ctlall),
>  		.mode		=3D 0644,
>  		.proc_handler	=3D proc_doulongvec_minmax,
> +		.min		=3D 0,
> +		.max		=3D ULONG_MAX,
>  	},
>  	{
>  		.procname	=3D "shmmni",
> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> index f5145b32f6be..7d0bcd2b24ef 100644
> --- a/kernel/sysctl.c
> +++ b/kernel/sysctl.c
> @@ -423,11 +423,15 @@ int proc_uint_conv(ulong *u_ptr, uint *k_ptr, int d=
ir,
>  		ret =3D user_to_kern(u_ptr, &tmp_k);
>  		if (ret)
>  			return ret;
> -		if ((tbl->extra1 &&
> -		     *(uint *)tbl->extra1 > tmp_k) ||
> -		    (tbl->extra2 &&
> -		     *(uint *)tbl->extra2 < tmp_k))
> +		if (tbl->extra1 || tbl->extra2) {
> +			if ((tbl->extra1 &&
> +			     *(uint *)tbl->extra1 > tmp_k) ||
> +			    (tbl->extra2 &&
> +			     *(uint *)tbl->extra2 < tmp_k))
> +				return -ERANGE;
> +		} else if (tbl->min > tmp_k || tbl->max < tmp_k) {

One of the things that the void * pointers coded was whether there was a
value there to use for the range check. If there was not value (NULL),
then there was no check.

I see that you are changing all the callers in such a way that they
define the min max every time, but this is not really needed if you
end up calling a converter that does not check range, you will never
use those values.

Is there a way to tell from within the sysctl core that there needs to
be a range check? I think max =3D=3D min =3D=3D 0 is not a good option as z=
ero
is a valid value.

I wonder if we can use the hole (I think it is 2 byte) in the ctl_table
struct. Could we add a bit flag there and then code whether to do the
range check or not?

Best


>  			return -ERANGE;
> +		}
>  		WRITE_ONCE(*k_ptr, tmp_k);
>  	} else
>  		return user_to_kern(u_ptr, k_ptr);
> @@ -543,17 +547,19 @@ int proc_int_conv(bool *negp, ulong *u_ptr, int *k_=
ptr, int dir,
>  		ret =3D user_to_kern(negp, u_ptr, &tmp_k);
>  		if (ret)
>  			return ret;
> -		if ((tbl->extra1 && *(int *)tbl->extra1 > tmp_k) ||
> -		    (tbl->extra2 && *(int *)tbl->extra2 < tmp_k))
> +		if (tbl->extra1 || tbl->extra2) {
> +			if ((tbl->extra1 && *(int *)tbl->extra1 > tmp_k) ||
> +			    (tbl->extra2 && *(int *)tbl->extra2 < tmp_k))
> +				return -EINVAL;
> +		} else if ((long)tbl->min > tmp_k || (long)tbl->max < tmp_k) {
>  			return -EINVAL;
> +		}
>  		WRITE_ONCE(*k_ptr, tmp_k);
>  	} else
>  		return user_to_kern(negp, u_ptr, k_ptr);
>  	return 0;
>  }
> =20
> -
> -
>  static int sysctl_user_to_kern_int_conv(const bool *negp, const ulong *u=
_ptr,
>  					int *k_ptr)
>  {
> @@ -985,7 +991,7 @@ int proc_dou8vec_minmax(const struct ctl_table *table=
, int dir,
>  			void *buffer, size_t *lenp, loff_t *ppos)
>  {
>  	struct ctl_table tmp;
> -	unsigned int min =3D 0, max =3D 255U, val;
> +	unsigned int val;
>  	u8 *data =3D table->data;
>  	int res;
> =20
> @@ -997,10 +1003,6 @@ int proc_dou8vec_minmax(const struct ctl_table *tab=
le, int dir,
> =20
>  	tmp.maxlen =3D sizeof(val);
>  	tmp.data =3D &val;
> -	if (!tmp.extra1)
> -		tmp.extra1 =3D (unsigned int *) &min;
> -	if (!tmp.extra2)
> -		tmp.extra2 =3D (unsigned int *) &max;
> =20
>  	val =3D READ_ONCE(*data);
>  	res =3D proc_douintvec_minmax(&tmp, dir, buffer, lenp, ppos);
> @@ -1045,9 +1047,13 @@ int proc_ulong_conv(ulong *u_ptr, ulong *k_ptr, in=
t dir,
>  		ret =3D user_to_kern(u_ptr, &tmp_k);
>  		if (ret)
>  			return ret;
> -		if ((tbl->extra1 && *(ulong *)tbl->extra1 > tmp_k) ||
> -		    (tbl->extra2 && *(ulong *)tbl->extra2 < tmp_k))
> +		if (tbl->extra1 || tbl->extra2) {
> +			if ((tbl->extra1 && *(ulong *)tbl->extra1 > tmp_k) ||
> +			    (tbl->extra2 && *(ulong *)tbl->extra2 < tmp_k))
> +				return -ERANGE;
> +		} else if (tbl->min > tmp_k || tbl->max < tmp_k) {
>  			return -ERANGE;
> +		}
>  		WRITE_ONCE(*k_ptr, tmp_k);
>  	} else
>  		return user_to_kern(u_ptr, k_ptr);
> diff --git a/lib/test_sysctl.c b/lib/test_sysctl.c
> index 65ce42346170..eed2cc1bea82 100644
> --- a/lib/test_sysctl.c
> +++ b/lib/test_sysctl.c
> @@ -15,6 +15,7 @@
>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> =20
>  #include <linux/init.h>
> +#include <linux/limits.h>
>  #include <linux/jiffies.h>
>  #include <linux/list.h>
>  #include <linux/module.h>
> @@ -217,6 +218,8 @@ static const struct ctl_table test_table_unregister[]=
 =3D {
>  		.maxlen		=3D sizeof(int),
>  		.mode		=3D 0644,
>  		.proc_handler	=3D proc_dointvec_minmax,
> +		.min		=3D INT_MIN,
> +		.max		=3D INT_MAX,
>  	},
>  };
> =20
> diff --git a/mm/util.c b/mm/util.c
> index 8acfe2148ba5..2f2bc521868a 100644
> --- a/mm/util.c
> +++ b/mm/util.c
> @@ -1,5 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  #include <linux/mm.h>
> +#include <linux/limits.h>
>  #include <linux/slab.h>
>  #include <linux/string.h>
>  #include <linux/compiler.h>
> @@ -880,6 +881,8 @@ static const struct ctl_table util_sysctl_table[] =3D=
 {
>  		.maxlen		=3D sizeof(sysctl_user_reserve_kbytes),
>  		.mode		=3D 0644,
>  		.proc_handler	=3D proc_doulongvec_minmax,
> +		.min		=3D 0,
> +		.max		=3D ULONG_MAX,
>  	},
>  	{
>  		.procname	=3D "admin_reserve_kbytes",
> @@ -887,6 +890,8 @@ static const struct ctl_table util_sysctl_table[] =3D=
 {
>  		.maxlen		=3D sizeof(sysctl_admin_reserve_kbytes),
>  		.mode		=3D 0644,
>  		.proc_handler	=3D proc_doulongvec_minmax,
> +		.min		=3D 0,
> +		.max		=3D ULONG_MAX,
>  	},
>  };
> =20
> diff --git a/net/ieee802154/6lowpan/reassembly.c b/net/ieee802154/6lowpan=
/reassembly.c
> index ddb6a5817d09..a2167f76ecc3 100644
> --- a/net/ieee802154/6lowpan/reassembly.c
> +++ b/net/ieee802154/6lowpan/reassembly.c
> @@ -10,6 +10,7 @@
>  #define pr_fmt(fmt) "6LoWPAN: " fmt
> =20
>  #include <linux/net.h>
> +#include <linux/limits.h>
>  #include <linux/list.h>
>  #include <linux/netdevice.h>
>  #include <linux/random.h>
> @@ -332,12 +333,16 @@ static struct ctl_table lowpan_frags_ns_ctl_table[]=
 =3D {
>  		.maxlen		=3D sizeof(unsigned long),
>  		.mode		=3D 0644,
>  		.proc_handler	=3D proc_doulongvec_minmax,
> +		.min		=3D 0,
> +		.max		=3D ULONG_MAX,
>  	},
>  	{
>  		.procname	=3D "6lowpanfrag_low_thresh",
>  		.maxlen		=3D sizeof(unsigned long),
>  		.mode		=3D 0644,
>  		.proc_handler	=3D proc_doulongvec_minmax,
> +		.min		=3D 0,
> +		.max		=3D ULONG_MAX,
>  	},
>  	{
>  		.procname	=3D "6lowpanfrag_time",
> diff --git a/net/ipv4/ip_fragment.c b/net/ipv4/ip_fragment.c
> index c790d2f49487..75bc675e5579 100644
> --- a/net/ipv4/ip_fragment.c
> +++ b/net/ipv4/ip_fragment.c
> @@ -24,6 +24,7 @@
>  #define pr_fmt(fmt) "IPv4: " fmt
> =20
>  #include <linux/compiler.h>
> +#include <linux/limits.h>
>  #include <linux/module.h>
>  #include <linux/types.h>
>  #include <linux/mm.h>
> @@ -551,12 +552,16 @@ static struct ctl_table ip4_frags_ns_ctl_table[] =
=3D {
>  		.maxlen		=3D sizeof(unsigned long),
>  		.mode		=3D 0644,
>  		.proc_handler	=3D proc_doulongvec_minmax,
> +		.min		=3D 0,
> +		.max		=3D ULONG_MAX,
>  	},
>  	{
>  		.procname	=3D "ipfrag_low_thresh",
>  		.maxlen		=3D sizeof(unsigned long),
>  		.mode		=3D 0644,
>  		.proc_handler	=3D proc_doulongvec_minmax,
> +		.min		=3D 0,
> +		.max		=3D ULONG_MAX,
>  	},
>  	{
>  		.procname	=3D "ipfrag_time",
> diff --git a/net/ipv4/sysctl_net_ipv4.c b/net/ipv4/sysctl_net_ipv4.c
> index e3760daa3470..2ed9f59ea747 100644
> --- a/net/ipv4/sysctl_net_ipv4.c
> +++ b/net/ipv4/sysctl_net_ipv4.c
> @@ -7,6 +7,7 @@
>   */
> =20
>  #include <linux/sysctl.h>
> +#include <linux/limits.h>
>  #include <linux/seqlock.h>
>  #include <linux/init.h>
>  #include <linux/slab.h>
> @@ -564,6 +565,8 @@ static struct ctl_table ipv4_table[] =3D {
>  		.data		=3D &sysctl_tcp_mem,
>  		.mode		=3D 0644,
>  		.proc_handler	=3D proc_doulongvec_minmax,
> +		.min		=3D 0,
> +		.max		=3D ULONG_MAX,
>  	},
>  	{
>  		.procname	=3D "tcp_low_latency",
> @@ -614,6 +617,8 @@ static struct ctl_table ipv4_table[] =3D {
>  		.maxlen		=3D sizeof(sysctl_udp_mem),
>  		.mode		=3D 0644,
>  		.proc_handler	=3D proc_doulongvec_minmax,
> +		.min		=3D 0,
> +		.max		=3D ULONG_MAX,
>  	},
>  	{
>  		.procname	=3D "fib_sync_mem",
> @@ -778,6 +783,8 @@ static const struct ctl_table ipv4_net_table[] =3D {
>  		.maxlen		=3D sizeof(u8),
>  		.mode		=3D 0644,
>  		.proc_handler	=3D proc_dou8vec_minmax,
> +		.min		=3D 0,
> +		.max		=3D U8_MAX,
>  	},
>  	{
>  		.procname	=3D "ip_early_demux",
> @@ -785,6 +792,8 @@ static const struct ctl_table ipv4_net_table[] =3D {
>  		.maxlen		=3D sizeof(u8),
>  		.mode		=3D 0644,
>  		.proc_handler	=3D proc_dou8vec_minmax,
> +		.min		=3D 0,
> +		.max		=3D U8_MAX,
>  	},
>  	{
>  		.procname       =3D "udp_early_demux",
> @@ -792,6 +801,8 @@ static const struct ctl_table ipv4_net_table[] =3D {
>  		.maxlen         =3D sizeof(u8),
>  		.mode           =3D 0644,
>  		.proc_handler   =3D proc_dou8vec_minmax,
> +		.min           =3D 0,
> +		.max           =3D U8_MAX,
>  	},
>  	{
>  		.procname       =3D "tcp_early_demux",
> @@ -799,6 +810,8 @@ static const struct ctl_table ipv4_net_table[] =3D {
>  		.maxlen         =3D sizeof(u8),
>  		.mode           =3D 0644,
>  		.proc_handler   =3D proc_dou8vec_minmax,
> +		.min           =3D 0,
> +		.max           =3D U8_MAX,
>  	},
>  	{
>  		.procname       =3D "nexthop_compat_mode",
> @@ -845,6 +858,8 @@ static const struct ctl_table ipv4_net_table[] =3D {
>  		.maxlen		=3D sizeof(u8),
>  		.mode		=3D 0644,
>  		.proc_handler	=3D proc_dou8vec_minmax,
> +		.min		=3D 0,
> +		.max		=3D U8_MAX,
>  	},
>  	{
>  		.procname	=3D "ip_forward_use_pmtu",
> @@ -852,6 +867,8 @@ static const struct ctl_table ipv4_net_table[] =3D {
>  		.maxlen		=3D sizeof(u8),
>  		.mode		=3D 0644,
>  		.proc_handler	=3D proc_dou8vec_minmax,
> +		.min		=3D 0,
> +		.max		=3D U8_MAX,
>  	},
>  	{
>  		.procname	=3D "ip_forward_update_priority",
> @@ -868,6 +885,8 @@ static const struct ctl_table ipv4_net_table[] =3D {
>  		.maxlen		=3D sizeof(u8),
>  		.mode		=3D 0644,
>  		.proc_handler	=3D proc_dou8vec_minmax,
> +		.min		=3D 0,
> +		.max		=3D U8_MAX,
>  	},
>  	{
>  		.procname	=3D "ip_autobind_reuse",
> @@ -884,6 +903,8 @@ static const struct ctl_table ipv4_net_table[] =3D {
>  		.maxlen		=3D sizeof(u8),
>  		.mode		=3D 0644,
>  		.proc_handler	=3D proc_dou8vec_minmax,
> +		.min		=3D 0,
> +		.max		=3D U8_MAX,
>  	},
>  	{
>  		.procname	=3D "tcp_fwmark_accept",
> @@ -891,6 +912,8 @@ static const struct ctl_table ipv4_net_table[] =3D {
>  		.maxlen		=3D sizeof(u8),
>  		.mode		=3D 0644,
>  		.proc_handler	=3D proc_dou8vec_minmax,
> +		.min		=3D 0,
> +		.max		=3D U8_MAX,
>  	},
>  #ifdef CONFIG_NET_L3_MASTER_DEV
>  	{
> @@ -909,6 +932,8 @@ static const struct ctl_table ipv4_net_table[] =3D {
>  		.maxlen		=3D sizeof(u8),
>  		.mode		=3D 0644,
>  		.proc_handler	=3D proc_dou8vec_minmax,
> +		.min		=3D 0,
> +		.max		=3D U8_MAX,
>  	},
>  	{
>  		.procname	=3D "tcp_base_mss",
> @@ -956,6 +981,8 @@ static const struct ctl_table ipv4_net_table[] =3D {
>  		.maxlen		=3D sizeof(u8),
>  		.mode		=3D 0644,
>  		.proc_handler	=3D proc_dou8vec_minmax,
> +		.min		=3D 0,
> +		.max		=3D U8_MAX,
>  	},
>  	{
>  		.procname	=3D "igmp_max_memberships",
> @@ -1013,6 +1040,8 @@ static const struct ctl_table ipv4_net_table[] =3D {
>  		.maxlen		=3D sizeof(u8),
>  		.mode		=3D 0644,
>  		.proc_handler	=3D proc_dou8vec_minmax,
> +		.min		=3D 0,
> +		.max		=3D U8_MAX,
>  	},
>  	{
>  		.procname	=3D "tcp_keepalive_intvl",
> @@ -1036,6 +1065,8 @@ static const struct ctl_table ipv4_net_table[] =3D {
>  		.maxlen		=3D sizeof(u8),
>  		.mode		=3D 0644,
>  		.proc_handler	=3D proc_dou8vec_minmax,
> +		.min		=3D 0,
> +		.max		=3D U8_MAX,
>  	},
>  #ifdef CONFIG_SYN_COOKIES
>  	{
> @@ -1044,6 +1075,8 @@ static const struct ctl_table ipv4_net_table[] =3D {
>  		.maxlen		=3D sizeof(u8),
>  		.mode		=3D 0644,
>  		.proc_handler	=3D proc_dou8vec_minmax,
> +		.min		=3D 0,
> +		.max		=3D U8_MAX,
>  	},
>  #endif
>  	{
> @@ -1078,6 +1111,8 @@ static const struct ctl_table ipv4_net_table[] =3D {
>  		.maxlen		=3D sizeof(u8),
>  		.mode		=3D 0644,
>  		.proc_handler	=3D proc_dou8vec_minmax,
> +		.min		=3D 0,
> +		.max		=3D U8_MAX,
>  	},
>  	{
>  		.procname	=3D "tcp_orphan_retries",
> @@ -1085,6 +1120,8 @@ static const struct ctl_table ipv4_net_table[] =3D {
>  		.maxlen		=3D sizeof(u8),
>  		.mode		=3D 0644,
>  		.proc_handler	=3D proc_dou8vec_minmax,
> +		.min		=3D 0,
> +		.max		=3D U8_MAX,
>  	},
>  	{
>  		.procname	=3D "tcp_fin_timeout",
> @@ -1212,6 +1249,8 @@ static const struct ctl_table ipv4_net_table[] =3D {
>  		.maxlen		=3D sizeof(u8),
>  		.mode		=3D 0644,
>  		.proc_handler	=3D proc_dou8vec_minmax,
> +		.min		=3D 0,
> +		.max		=3D U8_MAX,
>  	},
>  	{
>  		.procname	=3D "tcp_window_scaling",
> @@ -1219,6 +1258,8 @@ static const struct ctl_table ipv4_net_table[] =3D {
>  		.maxlen		=3D sizeof(u8),
>  		.mode		=3D 0644,
>  		.proc_handler	=3D proc_dou8vec_minmax,
> +		.min		=3D 0,
> +		.max		=3D U8_MAX,
>  	},
>  	{
>  		.procname	=3D "tcp_timestamps",
> @@ -1226,6 +1267,8 @@ static const struct ctl_table ipv4_net_table[] =3D {
>  		.maxlen		=3D sizeof(u8),
>  		.mode		=3D 0644,
>  		.proc_handler	=3D proc_dou8vec_minmax,
> +		.min		=3D 0,
> +		.max		=3D U8_MAX,
>  	},
>  	{
>  		.procname	=3D "tcp_early_retrans",
> @@ -1242,6 +1285,8 @@ static const struct ctl_table ipv4_net_table[] =3D {
>  		.maxlen		=3D sizeof(u8),
>  		.mode		=3D 0644,
>  		.proc_handler	=3D proc_dou8vec_minmax,
> +		.min		=3D 0,
> +		.max		=3D U8_MAX,
>  	},
>  	{
>  		.procname       =3D "tcp_thin_linear_timeouts",
> @@ -1249,6 +1294,8 @@ static const struct ctl_table ipv4_net_table[] =3D {
>  		.maxlen         =3D sizeof(u8),
>  		.mode           =3D 0644,
>  		.proc_handler   =3D proc_dou8vec_minmax,
> +		.min           =3D 0,
> +		.max           =3D U8_MAX,
>  	},
>  	{
>  		.procname	=3D "tcp_slow_start_after_idle",
> @@ -1256,6 +1303,8 @@ static const struct ctl_table ipv4_net_table[] =3D {
>  		.maxlen		=3D sizeof(u8),
>  		.mode		=3D 0644,
>  		.proc_handler	=3D proc_dou8vec_minmax,
> +		.min		=3D 0,
> +		.max		=3D U8_MAX,
>  	},
>  	{
>  		.procname	=3D "tcp_retrans_collapse",
> @@ -1263,6 +1312,8 @@ static const struct ctl_table ipv4_net_table[] =3D {
>  		.maxlen		=3D sizeof(u8),
>  		.mode		=3D 0644,
>  		.proc_handler	=3D proc_dou8vec_minmax,
> +		.min		=3D 0,
> +		.max		=3D U8_MAX,
>  	},
>  	{
>  		.procname	=3D "tcp_stdurg",
> @@ -1270,6 +1321,8 @@ static const struct ctl_table ipv4_net_table[] =3D {
>  		.maxlen		=3D sizeof(u8),
>  		.mode		=3D 0644,
>  		.proc_handler	=3D proc_dou8vec_minmax,
> +		.min		=3D 0,
> +		.max		=3D U8_MAX,
>  	},
>  	{
>  		.procname	=3D "tcp_rfc1337",
> @@ -1277,6 +1330,8 @@ static const struct ctl_table ipv4_net_table[] =3D {
>  		.maxlen		=3D sizeof(u8),
>  		.mode		=3D 0644,
>  		.proc_handler	=3D proc_dou8vec_minmax,
> +		.min		=3D 0,
> +		.max		=3D U8_MAX,
>  	},
>  	{
>  		.procname	=3D "tcp_abort_on_overflow",
> @@ -1284,6 +1339,8 @@ static const struct ctl_table ipv4_net_table[] =3D {
>  		.maxlen		=3D sizeof(u8),
>  		.mode		=3D 0644,
>  		.proc_handler	=3D proc_dou8vec_minmax,
> +		.min		=3D 0,
> +		.max		=3D U8_MAX,
>  	},
>  	{
>  		.procname	=3D "tcp_fack",
> @@ -1291,6 +1348,8 @@ static const struct ctl_table ipv4_net_table[] =3D {
>  		.maxlen		=3D sizeof(u8),
>  		.mode		=3D 0644,
>  		.proc_handler	=3D proc_dou8vec_minmax,
> +		.min		=3D 0,
> +		.max		=3D U8_MAX,
>  	},
>  	{
>  		.procname	=3D "tcp_max_reordering",
> @@ -1306,6 +1365,8 @@ static const struct ctl_table ipv4_net_table[] =3D {
>  		.maxlen		=3D sizeof(u8),
>  		.mode		=3D 0644,
>  		.proc_handler	=3D proc_dou8vec_minmax,
> +		.min		=3D 0,
> +		.max		=3D U8_MAX,
>  	},
>  	{
>  		.procname	=3D "tcp_app_win",
> @@ -1331,6 +1392,8 @@ static const struct ctl_table ipv4_net_table[] =3D {
>  		.maxlen		=3D sizeof(u8),
>  		.mode		=3D 0644,
>  		.proc_handler	=3D proc_dou8vec_minmax,
> +		.min		=3D 0,
> +		.max		=3D U8_MAX,
>  	},
>  	{
>  		.procname	=3D "tcp_no_metrics_save",
> @@ -1338,6 +1401,8 @@ static const struct ctl_table ipv4_net_table[] =3D {
>  		.maxlen		=3D sizeof(u8),
>  		.mode		=3D 0644,
>  		.proc_handler	=3D proc_dou8vec_minmax,
> +		.min		=3D 0,
> +		.max		=3D U8_MAX,
>  	},
>  	{
>  		.procname	=3D "tcp_no_ssthresh_metrics_save",
> @@ -1354,6 +1419,8 @@ static const struct ctl_table ipv4_net_table[] =3D {
>  		.maxlen		=3D sizeof(u8),
>  		.mode		=3D 0644,
>  		.proc_handler	=3D proc_dou8vec_minmax,
> +		.min		=3D 0,
> +		.max		=3D U8_MAX,
>  	},
>  	{
>  		.procname	=3D "tcp_rcvbuf_low_rtt",
> @@ -1370,6 +1437,8 @@ static const struct ctl_table ipv4_net_table[] =3D {
>  		.maxlen		=3D sizeof(u8),
>  		.mode		=3D 0644,
>  		.proc_handler	=3D proc_dou8vec_minmax,
> +		.min		=3D 0,
> +		.max		=3D U8_MAX,
>  	},
>  	{
>  		.procname	=3D "tcp_workaround_signed_windows",
> @@ -1377,6 +1446,8 @@ static const struct ctl_table ipv4_net_table[] =3D {
>  		.maxlen		=3D sizeof(u8),
>  		.mode		=3D 0644,
>  		.proc_handler	=3D proc_dou8vec_minmax,
> +		.min		=3D 0,
> +		.max		=3D U8_MAX,
>  	},
>  	{
>  		.procname	=3D "tcp_limit_output_bytes",
> @@ -1406,6 +1477,8 @@ static const struct ctl_table ipv4_net_table[] =3D {
>  		.maxlen		=3D sizeof(u8),
>  		.mode		=3D 0644,
>  		.proc_handler	=3D proc_dou8vec_minmax,
> +		.min		=3D 0,
> +		.max		=3D U8_MAX,
>  	},
>  	{
>  		.procname	=3D "tcp_min_rtt_wlen",
> @@ -1472,6 +1545,8 @@ static const struct ctl_table ipv4_net_table[] =3D {
>  		.maxlen		=3D sizeof(unsigned long),
>  		.mode		=3D 0644,
>  		.proc_handler	=3D proc_doulongvec_minmax,
> +		.min		=3D 0,
> +		.max		=3D ULONG_MAX,
>  	},
>  	{
>  		.procname	=3D "tcp_comp_sack_rtt_percent",
> @@ -1488,6 +1563,8 @@ static const struct ctl_table ipv4_net_table[] =3D {
>  		.maxlen		=3D sizeof(unsigned long),
>  		.mode		=3D 0644,
>  		.proc_handler	=3D proc_doulongvec_minmax,
> +		.min		=3D 0,
> +		.max		=3D ULONG_MAX,
>  	},
>  	{
>  		.procname	=3D "tcp_comp_sack_nr",
> @@ -1601,6 +1678,8 @@ static const struct ctl_table ipv4_net_table[] =3D {
>  		.maxlen         =3D sizeof(u8),
>  		.mode           =3D 0644,
>  		.proc_handler   =3D proc_dou8vec_minmax,
> +		.min           =3D 0,
> +		.max           =3D U8_MAX,
>  	},
>  	{
>  		.procname       =3D "tcp_plb_cong_thresh",
> diff --git a/net/ipv6/icmp.c b/net/ipv6/icmp.c
> index a95b0351824f..1ba2ff759075 100644
> --- a/net/ipv6/icmp.c
> +++ b/net/ipv6/icmp.c
> @@ -28,6 +28,7 @@
>  #define pr_fmt(fmt) "IPv6: " fmt
> =20
>  #include <linux/module.h>
> +#include <linux/limits.h>
>  #include <linux/errno.h>
>  #include <linux/types.h>
>  #include <linux/socket.h>
> @@ -1388,6 +1389,8 @@ static const struct ctl_table ipv6_icmp_table_templ=
ate[] =3D {
>  		.maxlen		=3D sizeof(u8),
>  		.mode		=3D 0644,
>  		.proc_handler =3D proc_dou8vec_minmax,
> +		.min		=3D 0,
> +		.max		=3D U8_MAX,
>  	},
>  	{
>  		.procname	=3D "echo_ignore_multicast",
> @@ -1395,6 +1398,8 @@ static const struct ctl_table ipv6_icmp_table_templ=
ate[] =3D {
>  		.maxlen		=3D sizeof(u8),
>  		.mode		=3D 0644,
>  		.proc_handler =3D proc_dou8vec_minmax,
> +		.min		=3D 0,
> +		.max		=3D U8_MAX,
>  	},
>  	{
>  		.procname	=3D "echo_ignore_anycast",
> @@ -1402,6 +1407,8 @@ static const struct ctl_table ipv6_icmp_table_templ=
ate[] =3D {
>  		.maxlen		=3D sizeof(u8),
>  		.mode		=3D 0644,
>  		.proc_handler =3D proc_dou8vec_minmax,
> +		.min		=3D 0,
> +		.max		=3D U8_MAX,
>  	},
>  	{
>  		.procname	=3D "ratemask",
> diff --git a/net/ipv6/netfilter/nf_conntrack_reasm.c b/net/ipv6/netfilter=
/nf_conntrack_reasm.c
> index be72c4346f8b..1f3ba85f6dca 100644
> --- a/net/ipv6/netfilter/nf_conntrack_reasm.c
> +++ b/net/ipv6/netfilter/nf_conntrack_reasm.c
> @@ -13,6 +13,7 @@
>  #define pr_fmt(fmt) "IPv6-nf: " fmt
> =20
>  #include <linux/errno.h>
> +#include <linux/limits.h>
>  #include <linux/types.h>
>  #include <linux/string.h>
>  #include <linux/net.h>
> @@ -55,12 +56,16 @@ static struct ctl_table nf_ct_frag6_sysctl_table[] =
=3D {
>  		.maxlen		=3D sizeof(unsigned long),
>  		.mode		=3D 0644,
>  		.proc_handler	=3D proc_doulongvec_minmax,
> +		.min		=3D 0,
> +		.max		=3D ULONG_MAX,
>  	},
>  	{
>  		.procname	=3D "nf_conntrack_frag6_high_thresh",
>  		.maxlen		=3D sizeof(unsigned long),
>  		.mode		=3D 0644,
>  		.proc_handler	=3D proc_doulongvec_minmax,
> +		.min		=3D 0,
> +		.max		=3D ULONG_MAX,
>  	},
>  };
> =20
> diff --git a/net/ipv6/reassembly.c b/net/ipv6/reassembly.c
> index a7964125c764..70c845385744 100644
> --- a/net/ipv6/reassembly.c
> +++ b/net/ipv6/reassembly.c
> @@ -26,6 +26,7 @@
>  #define pr_fmt(fmt) "IPv6: " fmt
> =20
>  #include <linux/errno.h>
> +#include <linux/limits.h>
>  #include <linux/types.h>
>  #include <linux/string.h>
>  #include <linux/socket.h>
> @@ -427,12 +428,16 @@ static struct ctl_table ip6_frags_ns_ctl_table[] =
=3D {
>  		.maxlen		=3D sizeof(unsigned long),
>  		.mode		=3D 0644,
>  		.proc_handler	=3D proc_doulongvec_minmax,
> +		.min		=3D 0,
> +		.max		=3D ULONG_MAX,
>  	},
>  	{
>  		.procname	=3D "ip6frag_low_thresh",
>  		.maxlen		=3D sizeof(unsigned long),
>  		.mode		=3D 0644,
>  		.proc_handler	=3D proc_doulongvec_minmax,
> +		.min		=3D 0,
> +		.max		=3D ULONG_MAX,
>  	},
>  	{
>  		.procname	=3D "ip6frag_time",
> diff --git a/net/ipv6/sysctl_net_ipv6.c b/net/ipv6/sysctl_net_ipv6.c
> index 1a0a36dcdabc..c870a364de60 100644
> --- a/net/ipv6/sysctl_net_ipv6.c
> +++ b/net/ipv6/sysctl_net_ipv6.c
> @@ -7,6 +7,7 @@
>   */
> =20
>  #include <linux/mm.h>
> +#include <linux/limits.h>
>  #include <linux/sysctl.h>
>  #include <linux/in6.h>
>  #include <linux/ipv6.h>
> @@ -68,6 +69,8 @@ static const struct ctl_table ipv6_table_template[] =3D=
 {
>  		.maxlen		=3D sizeof(u8),
>  		.mode		=3D 0644,
>  		.proc_handler	=3D proc_dou8vec_minmax,
> +		.min		=3D 0,
> +		.max		=3D U8_MAX,
>  	},
>  	{
>  		.procname	=3D "anycast_src_echo_reply",
> @@ -75,6 +78,8 @@ static const struct ctl_table ipv6_table_template[] =3D=
 {
>  		.maxlen		=3D sizeof(u8),
>  		.mode		=3D 0644,
>  		.proc_handler	=3D proc_dou8vec_minmax,
> +		.min		=3D 0,
> +		.max		=3D U8_MAX,
>  	},
>  	{
>  		.procname	=3D "flowlabel_consistency",
> @@ -82,6 +87,8 @@ static const struct ctl_table ipv6_table_template[] =3D=
 {
>  		.maxlen		=3D sizeof(u8),
>  		.mode		=3D 0644,
>  		.proc_handler	=3D proc_dou8vec_minmax,
> +		.min		=3D 0,
> +		.max		=3D U8_MAX,
>  	},
>  	{
>  		.procname	=3D "auto_flowlabels",
> @@ -97,6 +104,8 @@ static const struct ctl_table ipv6_table_template[] =
=3D {
>  		.maxlen		=3D sizeof(u8),
>  		.mode		=3D 0644,
>  		.proc_handler	=3D proc_dou8vec_minmax,
> +		.min		=3D 0,
> +		.max		=3D U8_MAX,
>  	},
>  	{
>  		.procname	=3D "idgen_retries",
> @@ -118,6 +127,8 @@ static const struct ctl_table ipv6_table_template[] =
=3D {
>  		.maxlen		=3D sizeof(u8),
>  		.mode		=3D 0644,
>  		.proc_handler	=3D proc_dou8vec_minmax,
> +		.min		=3D 0,
> +		.max		=3D U8_MAX,
>  	},
>  	{
>  		.procname	=3D "ip_nonlocal_bind",
> @@ -125,6 +136,8 @@ static const struct ctl_table ipv6_table_template[] =
=3D {
>  		.maxlen		=3D sizeof(u8),
>  		.mode		=3D 0644,
>  		.proc_handler	=3D proc_dou8vec_minmax,
> +		.min		=3D 0,
> +		.max		=3D U8_MAX,
>  	},
>  	{
>  		.procname	=3D "flowlabel_reflect",
> diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c
> index 63c5747f0f63..e5a5995c5753 100644
> --- a/net/mptcp/ctrl.c
> +++ b/net/mptcp/ctrl.c
> @@ -6,6 +6,7 @@
> =20
>  #ifdef CONFIG_SYSCTL
>  #include <linux/sysctl.h>
> +#include <linux/limits.h>
>  #endif
> =20
>  #include <net/net_namespace.h>
> @@ -317,6 +318,8 @@ static struct ctl_table mptcp_sysctl_table[] =3D {
>  		.maxlen =3D sizeof(unsigned int),
>  		.mode =3D 0644,
>  		.proc_handler =3D proc_douintvec_minmax,
> +		.min =3D 0,
> +		.max =3D UINT_MAX,
>  	},
>  	{
>  		.procname =3D "pm_type",
> @@ -356,6 +359,8 @@ static struct ctl_table mptcp_sysctl_table[] =3D {
>  		.maxlen =3D sizeof(u8),
>  		.mode =3D 0644,
>  		.proc_handler =3D proc_dou8vec_minmax,
> +		.min =3D 0,
> +		.max =3D U8_MAX,
>  	},
>  	{
>  		.procname =3D "path_manager",
> diff --git a/net/netfilter/ipvs/ip_vs_ctl.c b/net/netfilter/ipvs/ip_vs_ct=
l.c
> index ce9fe20d6106..6c29a901d139 100644
> --- a/net/netfilter/ipvs/ip_vs_ctl.c
> +++ b/net/netfilter/ipvs/ip_vs_ctl.c
> @@ -16,6 +16,7 @@
>  #define pr_fmt(fmt) "IPVS: " fmt
> =20
>  #include <linux/module.h>
> +#include <linux/limits.h>
>  #include <linux/init.h>
>  #include <linux/types.h>
>  #include <linux/capability.h>
> @@ -2778,6 +2779,8 @@ static struct ctl_table vs_vars[] =3D {
>  		.maxlen		=3D sizeof(unsigned long),
>  		.mode		=3D 0644,
>  		.proc_handler	=3D proc_doulongvec_minmax,
> +		.min		=3D 0,
> +		.max		=3D ULONG_MAX,
>  	},
>  	{
>  		.procname	=3D "sync_sock_size",
> diff --git a/net/netfilter/nf_conntrack_standalone.c b/net/netfilter/nf_c=
onntrack_standalone.c
> index d88a10230862..561db3aecada 100644
> --- a/net/netfilter/nf_conntrack_standalone.c
> +++ b/net/netfilter/nf_conntrack_standalone.c
> @@ -1,5 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0
>  #include <linux/types.h>
> +#include <linux/limits.h>
>  #include <linux/netfilter.h>
>  #include <linux/slab.h>
>  #include <linux/module.h>
> @@ -821,6 +822,8 @@ static const struct ctl_table nf_ct_sysctl_table[] =
=3D {
>  		.maxlen		=3D sizeof(u8),
>  		.mode		=3D 0644,
>  		.proc_handler	=3D proc_dou8vec_minmax,
> +		.min		=3D 0,
> +		.max		=3D U8_MAX,
>  	},
>  	[NF_SYSCTL_CT_PROTO_TIMEOUT_UDP] =3D {
>  		.procname	=3D "nf_conntrack_udp_timeout",
> diff --git a/net/rds/ib_sysctl.c b/net/rds/ib_sysctl.c
> index 2af678e71e3c..b7757f31001c 100644
> --- a/net/rds/ib_sysctl.c
> +++ b/net/rds/ib_sysctl.c
> @@ -31,6 +31,7 @@
>   *
>   */
>  #include <linux/kernel.h>
> +#include <linux/limits.h>
>  #include <linux/sysctl.h>
>  #include <linux/proc_fs.h>
> =20
> @@ -95,6 +96,8 @@ static struct ctl_table rds_ib_sysctl_table[] =3D {
>  		.maxlen         =3D sizeof(unsigned long),
>  		.mode           =3D 0644,
>  		.proc_handler   =3D proc_doulongvec_minmax,
> +		.min           =3D 0,
> +		.max           =3D ULONG_MAX,
>  	},
>  	{
>  		.procname	=3D "flow_control",
> diff --git a/net/sctp/sysctl.c b/net/sctp/sysctl.c
> index 2b94c211427d..59c6f22337ea 100644
> --- a/net/sctp/sysctl.c
> +++ b/net/sctp/sysctl.c
> @@ -24,6 +24,7 @@
>  #include <net/sctp/structs.h>
>  #include <net/sctp/sctp.h>
>  #include <linux/sysctl.h>
> +#include <linux/limits.h>
> =20
>  static int timer_max =3D 86400000; /* ms in one day */
>  static int sack_timer_min =3D 1;
> @@ -65,6 +66,8 @@ static struct ctl_table sctp_table[] =3D {
>  		.maxlen		=3D sizeof(sysctl_sctp_mem),
>  		.mode		=3D 0644,
>  		.proc_handler	=3D proc_doulongvec_minmax
> +		.min		=3D 0,
> +		.max		=3D ULONG_MAX,
>  	},
>  	{
>  		.procname	=3D "sctp_rmem",
> diff --git a/net/tipc/sysctl.c b/net/tipc/sysctl.c
> index 30d2e06e3d8c..8352c790c8fe 100644
> --- a/net/tipc/sysctl.c
> +++ b/net/tipc/sysctl.c
> @@ -38,6 +38,7 @@
>  #include "crypto.h"
>  #include "bcast.h"
>  #include <linux/sysctl.h>
> +#include <linux/limits.h>
> =20
>  static struct ctl_table_header *tipc_ctl_hdr;
> =20
> @@ -64,6 +65,8 @@ static struct ctl_table tipc_table[] =3D {
>  		.maxlen         =3D sizeof(sysctl_tipc_sk_filter),
>  		.mode           =3D 0644,
>  		.proc_handler   =3D proc_doulongvec_minmax,
> +		.min           =3D 0,
> +		.max           =3D ULONG_MAX,
>  	},
>  #ifdef CONFIG_TIPC_CRYPTO
>  	{
> @@ -90,6 +93,8 @@ static struct ctl_table tipc_table[] =3D {
>  		.maxlen		=3D sizeof(sysctl_tipc_bc_retruni),
>  		.mode		=3D 0644,
>  		.proc_handler	=3D proc_doulongvec_minmax,
> +		.min		=3D 0,
> +		.max		=3D ULONG_MAX,
>  	},
>  };
> =20
> --=20
> 2.25.1
>=20

--dylffndjuewr4vwx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmrvY1cACgkQupfNUreW
QU/79wv/SCrrTs8r0Y3haTkaht9zZRK26pUwIP6Ot/VGm0cxB0wkWr4pm1qRKnKP
/mCd6sXJj3XoMscuNlkUmLJS+GgJPj36HxUszTNBJTazWE4danJ3rMJMuMp1QHP8
dsA9qiaOsNY7ujtWoC4iQPjJJ/vhR0ZI82E5uquy/OOmMDegwAOebjTQrj1qD+rA
sJPjH4CUmJiM6ftgDlsD4u0kA17fGJpO9nSWHQ5MHVNwqmOM+D5VghGr9oLLcPVZ
t7svHgYGWi/D0RWty/A4v5XD2feUzYE5/56ood2KVT5KmuXV7EG5NYbUACnrPVLu
PkQS0QXn0yBCPAyAMkViyoUjsd9YLd7XQFkQvnzoVDcHV6EFuD4L0ETY/XS602T7
/v78vRBgsIC/bYPGLjWVm3XWGA4bFyjhFaOwbm6YEXhacYrOoB9pkHYI8+wGY2zX
kEbgUZVnuVqrpJxabhNIy496cRV8P4peS/H2e+7AT6YAl2/rnEm75h+fWERDtrPn
c3X+vHBv
=nSGQ
-----END PGP SIGNATURE-----

--dylffndjuewr4vwx--
